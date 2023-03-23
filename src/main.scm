#!/usr/bin/env -S guile --no-auto-compile -e main -s
!#

;; run with the run script
;; ./run
(use-modules (cgfs constants)
             (cgfs pixel)
             (cgfs vec)
             (cgfs viewport)
             (cgfs sphere)
             (cgfs math)
             (cgfs vec)
             (cgfs sdl)
             (cgfs canvas)
             (cgfs math)
             (cgfs ray)
             (cgfs camera))

(use-modules (ice-9 threads))

(use-modules (system foreign-library))
(use-modules (system foreign))
(use-modules (rnrs bytevectors))

(use-modules (ice-9 iconv))


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
         (define pixels (make-bytevector (* PIXEL_SIZE WIDTH HEIGHT) 0))
         (define eventbv (make-bytevector 512 0))

         (define camera (make-camera (make-vec3 0 0 0)
                                     (make-vec3 0 1 0)
                                     (make-vec3 0 0 1)))
         (define viewport (make-viewport 1 1 1))

         (define spheres (list (make-sphere 1
                                            (make-vec3 0 -1 3)
                                            (make-color 128 0 0))))
         ;; (make-sphere 1
         ;;              (make-vec3 2 0 4)
         ;;              (make-color 0 0 255))
         ;; (make-sphere 1
         ;;              (make-vec3 -2 0 4)
         ;;              (make-color 0 255 0))))

         (define stop #f)
         (while (not stop)
                (begin 
                  (while (not (= 0 (sdl_poll_event (bytevector->pointer eventbv))))
                         (begin (if (= (bytevector-u32-ref eventbv 0 (native-endianness)) SDL_QUIT)
                                    (set! stop #t))))

                  (par-for-each (lambda (x) 
                                  (for-each (lambda (y)
                                              (let ((D (canvas->vpcoord WIDTH HEIGHT viewport (cons x y))))
                                                (put-pixel! pixels 
                                                            x 
                                                            y 
                                                            (trace-ray spheres 
                                                                       (camera-pos camera) 
                                                                       D 
                                                                       0 
                                                                       (inf)))))
                                            (enumurate-interval 0 HEIGHT))) 
                                (enumurate-interval 0 WIDTH))

                  (draw window_p renderer_p texture_p pixels)))
         
         (sdl_quit)))
