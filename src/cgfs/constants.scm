(define-module (cgfs constants))

(use-modules (cgfs vec)
             (cgfs math)
             (cgfs pixel))

(use-modules (system foreign)
             (system foreign-library))

(define-public WIDTH 800)
(define-public HEIGHT 600)
(define-public PIXEL_SIZE 4)
(define-public NULL %null-pointer)
