#!/usr/bin/env -S guile -e main -s
!#

;; run with the run script
;; ./run

(use-modules (cgfs sdl))

(use-modules (system foreign-library))
(use-modules (system foreign))

(use-modules (rnrs bytevectors))
(use-modules (ice-9 iconv))

(define WIDTH 800)
(define HEIGHT 600)
(define NULL %null-pointer)

(define (draw window_p renderer_p texture_p pixels)
  (sdl_render_clear renderer_p)
  (sdl_update_texture texture_p NULL (bytevector->pointer pixels) (* WIDTH 4))
  (sdl_render_copy renderer_p texture_p NULL NULL)
  (sdl_render_present renderer_p))

(define (main args)
  (begin (display args)
         (sdl_init 20)
         (define window_p (sdl_create_window (bytevector->pointer (string->bytevector "Hello World" "UTF-8")) 
                                             0 0 WIDTH HEIGHT 0))
         (define renderer_p (sdl_create_renderer window_p -1 4))
         (sdl_set_min_size window_p WIDTH HEIGHT)
         (sdl_set_logical_size renderer_p WIDTH HEIGHT)
         (sdl_set_int_scale renderer_p 1)
         (sdl_window_resizable window_p 0)
         (define texture_p (sdl_create_texture renderer_p SDL_PIXELFORMAT_RGBA8888 SDL_TEXTUREACCESS_STREAMING WIDTH HEIGHT))
         (define pixels (make-bytevector (* 4 WIDTH HEIGHT) 0))
         (define eventbv (make-bytevector 512 0))

         (define stop #f)
         (while (not stop)
                (begin (display "Loop!\n")
                       (while (not (= 0 (sdl_poll_event (bytevector->pointer eventbv))))
                              (begin (if (= (bytevector-u32-ref eventbv 0 (native-endianness) ) SDL_QUIT)
                                         (set! stop #t))))
                       (draw window_p renderer_p texture_p pixels)))
         
         (sdl_quit)))
