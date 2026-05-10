;;; web/scheme-host/ws.ss
;;;
;;; RFC 6455 WebSocket framing on top of chez binary ports.
;;; Stub: handshake + frame codec land in Task 2.

(library (web-host ws)
  (export ws-handshake
          ws-read-frame
          ws-write-frame
          ws-close-frame)
  (import (chezscheme))

  (define (todo who) (error who "TODO Task 2"))

  ;; Computes Sec-WebSocket-Accept and writes the 101 response upgrade.
  (define (ws-handshake in out headers) (todo 'ws-handshake))

  ;; -> (opcode payload-bytes) | 'eof
  (define (ws-read-frame in) (todo 'ws-read-frame))

  ;; opcode : 'text | 'binary | 'ping | 'pong
  (define (ws-write-frame out opcode payload) (todo 'ws-write-frame))

  ;; code : exact integer (1000, 1001, ...)
  (define (ws-close-frame out code) (todo 'ws-close-frame)))
