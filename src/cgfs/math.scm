(define-module (cgfs math))

(use-modules (cgfs constants)
             (cgfs vec)
             (cgfs viewport))

(define nil '())

(define-public (clamp x) 
  (if (> x 255)
      255
      (if (< x 0)
          0
          x)))

;; convert canvas coordinate to screen coordinate, returns pair object
(define-public (cnv->scr coord)
  (cons (+ (car coord)
           (/ WIDTH 2))
        (- (/ HEIGHT 2)
           (cdr coord))))

(define-public (enumurate-interval low high)
  (if (> low (- high 1))
      nil
      (cons low (enumurate-interval (+ low 1) high))))

(define-public (square x) (* x x))
