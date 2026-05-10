;;; web/scheme-host/http.ss
;;;
;;; HTTP/1.1 request parser + response writer. Operates on the binary
;;; ports returned by chez sockets. Stub: real parser lands in Task 2.

(library (web-host http)
  (export http-read-request
          http-write-response
          http-upgrade?)
  (import (chezscheme))

  (define (todo who) (error who "TODO Task 2"))

  ;; in : binary input port
  ;; -> (method path headers-alist body-bytes)
  (define (http-read-request in) (todo 'http-read-request))

  ;; out : binary output port
  ;; status : exact integer
  ;; headers-alist : ((name . value) ...)
  ;; body : bytevector
  (define (http-write-response out status headers body)
    (todo 'http-write-response))

  ;; #t when the request asked for a WebSocket upgrade.
  (define (http-upgrade? headers) (todo 'http-upgrade?)))
