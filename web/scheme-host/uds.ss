;;; web/scheme-host/uds.ss
;;;
;;; Unix-domain-socket FFI for the Idris→Chez server.
;;;
;;; This file is loaded into the idris2-emitted .ss heap via
;;;   opts = "--codegen chez --directive extraRuntime=../scheme-host/uds.ss"
;;; in web/server/web-server.ipkg. The %foreign "scheme:<name>" declarations
;;; in Server.FFI.Chez bind to the procedures defined here.
;;;
;;; Wire format: length-prefixed frames. A frame is a 4-byte big-endian uint32
;;; payload length followed by exactly that many bytes of UTF-8 JSON.
;;;
;;; NOTE: This file is spliced INSIDE the idris2-emitted `(let () ... )`
;;; body, after Idris's `#!chezscheme` directive. We therefore can NOT
;;; place top-level forms here (`(import ...)`, `(load-shared-object ...)`)
;;; — Idris already imports `(chezscheme)` and loads `libc.so.6` at the
;;; real top level of the generated `.ss`. Only `define` forms allowed.

;;; ---- raw libc syscalls -------------------------------------------------

(define c-socket
  (foreign-procedure "socket" (int int int) int))
(define c-bind
  (foreign-procedure "bind" (int u8* int) int))
(define c-listen
  (foreign-procedure "listen" (int int) int))
(define c-accept
  (foreign-procedure "accept" (int void* void*) int))
(define c-read
  (foreign-procedure "read" (int u8* size_t) ssize_t))
(define c-write
  (foreign-procedure "write" (int u8* size_t) ssize_t))
(define c-close
  (foreign-procedure "close" (int) int))
(define c-unlink
  (foreign-procedure "unlink" (string) int))
(define c-strerror
  (foreign-procedure "strerror" (int) string))

;; AF_UNIX = 1, SOCK_STREAM = 1, sa_family_t is a 2-byte short on Linux.
;; sockaddr_un on Linux glibc:
;;   uint16_t sun_family;          ; bytes 0..1
;;   char     sun_path[108];       ; bytes 2..109
;; Total size = 110 bytes.
(define AF_UNIX 1)
(define SOCK_STREAM 1)
(define SOCKADDR_UN_SIZE 110)

(define (make-sockaddr-un path)
  (let* ((bv (make-bytevector SOCKADDR_UN_SIZE 0))
         (pb (string->utf8 path)))
    ;; sun_family low byte, high byte (LE on x86_64)
    (bytevector-u8-set! bv 0 AF_UNIX)
    (bytevector-u8-set! bv 1 0)
    ;; sun_path
    (let loop ((i 0))
      (when (< i (bytevector-length pb))
        (bytevector-u8-set! bv (+ 2 i) (bytevector-u8-ref pb i))
        (loop (+ i 1))))
    bv))

;;; ---- helpers ----------------------------------------------------------

(define (errno-message)
  ;; Chez doesn't expose errno directly; we read it via the foreign
  ;; helper `__errno_location` (glibc). Cheap once-per-fault.
  (let* ((errno-loc (foreign-procedure "__errno_location" () void*))
         (loc (errno-loc)))
    ;; Read int at loc.
    (define c-deref-int
      (foreign-procedure "memcpy" (u8* void* size_t) void*))
    (let ((buf (make-bytevector 4 0)))
      (c-deref-int buf loc 4)
      (let ((e (bytevector-s32-ref buf 0 (endianness little))))
        (cons e (c-strerror e))))))

(define (fail who)
  (let ((e (errno-message)))
    (error who "syscall failed: errno=~a ~a" (car e) (cdr e))))

;;; ---- public API -------------------------------------------------------

;;; uds-listen : string -> int (server fd)
;;; Unlinks any stale path first, then binds + listens (backlog 16).
(define (uds-listen path)
  (c-unlink path)                          ; ignore failure
  (let ((fd (c-socket AF_UNIX SOCK_STREAM 0)))
    (when (< fd 0) (fail 'uds-listen/socket))
    (let* ((addr (make-sockaddr-un path))
           (rc (c-bind fd addr SOCKADDR_UN_SIZE)))
      (when (< rc 0) (c-close fd) (fail 'uds-listen/bind)))
    (let ((rc (c-listen fd 16)))
      (when (< rc 0) (c-close fd) (fail 'uds-listen/listen)))
    fd))

;;; uds-accept : int -> int (client fd)
;;; Blocks until a client connects.
(define (uds-accept server-fd)
  (let ((fd (c-accept server-fd 0 0)))
    (when (< fd 0) (fail 'uds-accept))
    fd))

;;; read-fully : int int -> bytevector
;;; Loops on short reads until we have exactly `len` bytes; returns #f on EOF.
(define (read-fully fd len)
  (let ((bv (make-bytevector len 0)))
    (let loop ((off 0))
      (if (= off len)
          bv
          (let* ((tmp (make-bytevector (- len off) 0))
                 (n (c-read fd tmp (- len off))))
            (cond
              ((< n 0) (fail 'uds-read))
              ((= n 0) #f)             ; EOF mid-frame
              (else
                (bytevector-copy! tmp 0 bv off n)
                (loop (+ off n)))))))))

(define (write-fully fd bv)
  (let ((len (bytevector-length bv)))
    (let loop ((off 0))
      (when (< off len)
        (let* ((tmp (make-bytevector (- len off) 0))
               (_ (bytevector-copy! bv off tmp 0 (- len off)))
               (n (c-write fd tmp (- len off))))
          (when (< n 0) (fail 'uds-write))
          (loop (+ off n)))))))

;;; uds-read-frame : int -> string (or empty string on EOF/connection close)
(define (uds-read-frame fd)
  (let ((hdr (read-fully fd 4)))
    (if (not hdr)
        ""
        (let ((len (bytevector-u32-ref hdr 0 (endianness big))))
          (if (= len 0)
              ""
              (let ((body (read-fully fd len)))
                (if body
                    (utf8->string body)
                    "")))))))

;;; uds-write-frame : int string -> ()
(define (uds-write-frame fd payload)
  (let* ((body (string->utf8 payload))
         (len (bytevector-length body))
         (hdr (make-bytevector 4 0)))
    (bytevector-u32-set! hdr 0 len (endianness big))
    (write-fully fd hdr)
    (write-fully fd body)))

;;; uds-close : int -> ()
(define (uds-close fd) (c-close fd))
