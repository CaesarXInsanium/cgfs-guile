(define-module (cgfs vec))

(use-modules (cgfs math)
             (cgfs pixel))

(define-public (vecx vc)
  (vector-ref vc 0))
(define-public (vecy vc)
  (vector-ref vc 1))
(define-public (vecz vc)
  (vector-ref vc 2))
(define-public (vecw vc)
  (vector-ref vc 3))

(define-public (vec3? v)
  (and (vector? v)
       (= 3 (vector-length v))))

(define-public (make-vec3 x y z)
  (vector  x 
           y
           z))

(define-public (vnorm v)
  (sqrt (+ (square (vecx v))
           (square (vecy v))
           (square (vecz v)))))

(define-public (vnormalize v)
  (let ((norm (vnorm v)))
    (make-vec3 (/ (vecx v) norm)
               (/ (vecy v) norm)
               (/ (vecz v) norm))))

(define-public (vadd v w)
  (make-vec3 (+ (vecx v) (vecx w))
             (+ (vecy v) (vecy w))
             (+ (vecz v) (vecz w))))
(define-public (vsub v w)
  (make-vec3 (- (vecx v) (vecx w))
             (- (vecy v) (vecy w))
             (- (vecz v) (vecz w))))

(define-public (vscale v x)
  (make-vec3 (* (vecx v) x)
             (* (vecy v) x)
             (* (vecz v) x)))

(define-public (vdot v w)
  (+ (* (vecx v) (vecx w))
     (* (vecy v) (vecy w))
     (* (vecz v) (vecz w))))

(define-public (vangle v w)
  (let ((dot (vdot v w))
        (vnorm (vnorm v))
        (wnorm (vnorm w)))
    (asin (/ dot
             (* vnorm wnorm)))))

(define-public (vcross v w)
  (let ((x (- (* (vecy v) (vecz w))
              (* (vecz v) (vecy w))))
        (y (- (* (vecx v) (vecz w))
              (* (vecz v) (vecx w))))
        (z (- (* (vecx v) (vecy w))
              (* (vecy v) (vecx w)))))
    (make-vec3 x y z)))


(define-public (vcross v w)
  (make-vec3))

(define-public (make-color r g b)
  (make-vec3 r g b))

(define-public (vec->pixel color)
  (make-pixel (clamp (round (vecx color)))
              (clamp (round (vecy color)))
              (clamp (round (vecz color)))))
