;; Module Imports
(use-modules (rnrs bytevectors))
(use-modules (ice-9 textual-ports))

;; Constants
(define WIDTH 80)
(define HEIGHT 60)
(define STDOUT (current-output-port))
(define SCREEN (make-array (make-bytevector 3) WIDTH HEIGHT))

;; Functions
(define (clamp x)
  (cond ((< x 0) 0)
        ((> x 255) 255)
        (else x)))


(define (make-pixel r g b)
  (let ((bv (make-bytevector 3)))
    (begin (bytevector-u8-set! bv 0 r)
           (bytevector-u8-set! bv 1 g)
           (bytevector-u8-set! bv 2 b)
           bv)))

(define (print-pixel! pixel port)
  (let ((r (bytevector-u8-ref pixel 0))
        (g (bytevector-u8-ref pixel 0))
        (b (bytevector-u8-ref pixel 0)))
    (begin (display " " port)
           (display r port)
           (display " " port)
           (display g port)
           (display " " port)
           (display b port)
           (display " " port))))

(define (print-row! row port)
  (for-each (lambda (color) 
              (begin (print-pixel! color port))) row)
  (display #\newline port))

(define ppm-print!
  (lambda (screen port) 
    (begin (display "P3" port)
           (display #\newline port)
           (display WIDTH port)
           (display " " port)
           (display HEIGHT port)
           (display #\newline port)
           (display "255" port)
           (display #\newline port)
           (for-each (lambda (row) (begin (print-row! row port))) (array->list screen)))))

(define make-coord (lambda (x y) (cons x y)))

(define (canvas->screen coord)
  (let ((x (car coord))
        (y (cdr coord)))
    (cons (+ x (/ WIDTH 2)) (- (/ HEIGHT 2) y))))

;; takes in canvas coordinates and places color on location
(define (put-pixel! screen coord color)
  (let ((scoord (canvas->screen coord)))
    (if (array-in-bounds screen (car scoord) (cdr scoord))
        (array-set! screen (car scoord) (cdr scoord))
        (begin (display "Bad Coords: ")
               (display coord)
               (newline)
               (display " ,Scoords: ")
               (display scoord)
               (newline)
               #f))))

;; Raytrace!

(define target (open-output-file "result.ppm"))
(call-with-port target (lambda (port) (ppm-print! SCREEN target)))
