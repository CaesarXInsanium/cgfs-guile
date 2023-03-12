(define (make-image columns rows)
  (if (= rows 0)
      (list)
      (cons (make-list columns (list)) (make-image columns (- rows 1)))))

(define (image-fill! image colour)
  (if (not (null? image))
      (begin (list-fill! (car image) colour) (image-fill! (cdr image) colour))))

(define (image-set! image column row colour)
  (list-set! (list-get image row) column colour))

(define (image-get image column row)
  (list-get (list-get image row) column))
(define (make-list length object)
  (if (= length 0)
      (list)
      (cons object (make-list (- length 1) object))))

(define (list-fill! list object)
  (if (not (null? list))
      (begin (set-car! list object) (list-fill! (cdr list) object))))

(define (list-set! list element object)
  (if (= element 1)
      (set-car! list object)
      (list-set! (cdr list) (- element 1) object)))

(define (list-get list element)
  (if (= element 1)
      (car list)
      (list-get (cdr list) (- element 1))))(define (write-ppm image file))

(define (write-image image)
  (define (write-row row)
    (define (write-colour colour)
      (if (not (null? colour))
          (begin (write-char (integer->char (car colour)))
                 (write-colour (cdr colour)))))
    (if (not (null? row))
        (begin (write-colour (car row)) (write-row (cdr row)))))
  (if (not (null? image))
      (begin (write-row (car image)) (write-image (cdr image)))))

(define image (make-image 3 2))
(image-fill! image *black*)
(image-set! image 2 1 *blue*)

(with-output-to-file file
  (lambda ()
    (begin (display "P6")
           (newline)
           (display (length (car image)))
           (display " ")
           (display (length image))
           (newline)
           (display 255)
           (newline)
           (write-image image))))

(display image)
(newline)