(define-module (cgfs pixel))

(use-modules (system foreign-library))
(use-modules (system foreign))
(use-modules (rnrs bytevectors))

(use-modules (cgfs constants)
             (cgfs vec))



;; return PIXEL_SIZE
(define-public WHITE (let ((bv (make-bytevector 4 0)))
                       (begin (bytevector-u8-set! bv 3 255)
                              bv)))

;; returns bytevector value representing pixel u32 value
(define-public (make-pixel r g b)
  (let ((br (bytevector-copy WHITE)))
    (begin (bytevector-u8-set! br 0 r)
           (bytevector-u8-set! br 1 g)
           (bytevector-u8-set! br 2 b)
           br)))
