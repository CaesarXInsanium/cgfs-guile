(define-module (cgfs canvas))

(use-modules (system foreign-library))
(use-modules (system foreign))
(use-modules (rnrs bytevectors))

(use-modules (cgfs constants)
             (cgfs pixel)
             (cgfs math)
             (cgfs vec))


;;Scheme Procedure: bytevector-copy! source source-start target target-start len
(define-public (set-pixel! pixelsbv x y pixelbv)
  (let ((index (* PIXEL_SIZE
                  (+ x (* y WIDTH)))))
    (bytevector-copy! pixelbv 0 pixelsbv index PIXEL_SIZE)))

(define-public (clear-screen! screenbv)
  (bytevector-fill! screenbv 1))

(define-public (put-pixel! screen x y color)
  (let ((coords (cnv->scr (cons x y)))
        (pixel (vec->pixel color)))
    (set-pixel! screen (car coords) (cdr coords) pixel)))
