(define-module (cgfs canvas))

(use-modules (system foreign-library))
(use-modules (system foreign))
(use-modules (rnrs bytevectors))

(use-modules (cgfs constants))
(use-modules (cgfs pixel))


(define-public (set-pixel! pixels x y pixelu32)
  (let ((index (* PIXEL_SIZE
                  (+ x (* y WIDTH)))))
    (bytevector-u32-set! pixels index pixelu32 (native-endianness))))
