;;; web/scheme-host/host.ss
;;;
;;; Chez Scheme entrypoint that loads the Idris-emitted image and exposes
;;; the `web-host-*` primitives bound by web/server/src/Server/FFI/Chez.idr.
;;; See ./README.md for the FFI contract and boot order.
;;;
;;; STUB. Real socket/accept loop wires up in Task 2.

(library (web-host)
  (export web-host-register-route
          web-host-register-ws
          web-host-listen
          web-host-req-method
          web-host-req-path
          web-host-req-header
          web-host-req-body
          web-host-resp-make
          web-host-ws-send
          web-host-ws-close
          web-host-now-millis
          web-host-rand-bytes)
  (import (chezscheme))

  (define (todo who) (error who "TODO Task 2"))

  (define (web-host-register-route path handler) (todo 'web-host-register-route))
  (define (web-host-register-ws    path handler) (todo 'web-host-register-ws))
  (define (web-host-listen         port)         (todo 'web-host-listen))

  (define (web-host-req-method  req)              (todo 'web-host-req-method))
  (define (web-host-req-path    req)              (todo 'web-host-req-path))
  (define (web-host-req-header  req name)         (todo 'web-host-req-header))
  (define (web-host-req-body    req)              (todo 'web-host-req-body))
  (define (web-host-resp-make   status hdrs body) (todo 'web-host-resp-make))

  (define (web-host-ws-send  conn buf)            (todo 'web-host-ws-send))
  (define (web-host-ws-close conn code)           (todo 'web-host-ws-close))

  (define (web-host-now-millis)                   (todo 'web-host-now-millis))
  (define (web-host-rand-bytes n)                 (todo 'web-host-rand-bytes)))
