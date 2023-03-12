;; SDL2 Bindings
(define-module (cgfs sdl))

(use-modules (system foreign-library))
(use-modules (system foreign))

(use-modules (rnrs bytevectors))

(define SDL2 (load-foreign-library "libSDL2"))

(if (foreign-library? SDL2)
    (display "Successfully Load SDL2\n")
    (error "Failed to Load SDL2"))

;; (define-public SDL_INIT_VIDEO (bytevector->pointer (u8-list->bytevector (list 00 00 00 20))))
(define pointer '*)

(define-public sdl_init 
  (foreign-library-function SDL2 
                            "SDL_Init"
                            #:return-type int32
                            #:arg-types (list uint32)))
(define-public sdl_quit
  (foreign-library-function SDL2 
                            "SDL_Quit"
                            #:return-type void
                            #:arg-types '()))

(define-public sdl_create_window 
  (foreign-library-function SDL2
                            "SDL_CreateWindow"
                            #:return-type '*
                            #:arg-types (list '* int int int int uint32)))

(define-public sdl_create_renderer
  (foreign-library-function SDL2
                            "SDL_CreateRenderer"
                            #:return-type '*
                            #:arg-types (list '* int uint32)))

(define-public sdl_set_min_size (foreign-library-function SDL2
                                                          "SDL_SetWindowMinimumSize"
                                                          #:return-type void
                                                          #:arg-types (list '* int int)))

(define-public sdl_set_logical_size (foreign-library-function SDL2
                                                              "SDL_RenderSetLogicalSize"
                                                              #:return-type void
                                                              #:arg-types (list '* int int)))

(define-public sdl_set_int_scale (foreign-library-function SDL2
                                                           "SDL_RenderSetIntegerScale"
                                                           #:return-type void
                                                           #:arg-types (list '* int)))

(define-public sdl_window_resizable (foreign-library-function SDL2
                                                              "SDL_SetWindowResizable"
                                                              #:return-type void
                                                              #:arg-types (list '* int)))

(define-public sdl_create_texture (foreign-library-function SDL2
                                                            "SDL_CreateTexture"
                                                            #:return-type '* 
                                                            #:arg-types (list '* uint32 int int int)))


(define-public sdl_render_clear (foreign-library-function SDL2
                                                          "SDL_RenderClear"
                                                          #:return-type void 
                                                          #:arg-types (list '*)))

(define-public sdl_update_texture (foreign-library-function SDL2
                                                            "SDL_UpdateTexture"
                                                            #:return-type void 
                                                            #:arg-types (list '* '* '* int)))

(define-public sdl_render_copy (foreign-library-function SDL2
                                                         "SDL_RenderCopy"
                                                         #:return-type void 
                                                         #:arg-types (list '* '* '* '*)))

(define-public sdl_render_present (foreign-library-function SDL2
                                                            "SDL_RenderPresent"
                                                            #:return-type void 
                                                            #:arg-types (list '*)))

(define-public sdl_poll_event (foreign-library-function SDL2
                                                        "SDL_PollEvent"
                                                        #:return-type int
                                                        #:arg-types (list '*)))
(define-public SDL_INIT_VIDEO 20)
(define-public SDL_PIXELFORMAT_RGBA8888 373694468)
(define-public SDL_TEXTUREACCESS_STREAMING 1)
(define-public SDL_QUIT 256)
