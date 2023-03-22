(define-module (cgfs constants))

(use-modules (cgfs vec)
             (cgfs math)
             (cgfs pixel))

(use-modules (system foreign)
             (system foreign-library))

(display "This Module is Getting Loaded!\n")

(define-public WIDTH 1000)
(define-public HEIGHT 900)
(define-public PIXEL_SIZE 4)
(define-public NULL %null-pointer)
(define-public NIL '())

(define-public BACKGROUND-COLOR (make-color 0 0 0))
