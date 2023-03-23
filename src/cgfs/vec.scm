(define-module (cgfs vec))

(use-modules (cgfs math)
             (cgfs constants)
             (cgfs pixel)
             (cgfs camera)
             (cgfs viewport))


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

(define-public (vadds v s)
  (make-vec3 (+ (vecx v) s)
             (+ (vecy v) s)
             (+ (vecz v) s)))

(define-public (vsubs v s)
  (vadds v (neg s)))

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
        (vorm (vnorm v))
        (worm (vnorm w)))
    (asin (/ dot
             (* vorm worm)))))

(define-public (vcross v w)
  (let ((x (- (* (vecy v) (vecz w))
              (* (vecz v) (vecy w))))
        (y (- (* (vecx v) (vecz w))
              (* (vecz v) (vecx w))))
        (z (- (* (vecx v) (vecy w))
              (* (vecy v) (vecx w)))))
    (make-vec3 x y z)))

;; get distance between two points
(define-public (vdist v w)
  (sqrt (+ (square (- (vecx w)
                      (vecx v)))
           (square (- (vecy w)
                      (vecy v)))
           (square (- (vecz w)
                      (vecz v))))))


(define-public (make-color r g b)
  (make-vec3 (clamp r) (clamp g) (clamp b)))

(define-public (vec->pixel color)
  (make-pixel (clamp (vecx color))
              (clamp (vecy color))
              (clamp (vecz color))))
