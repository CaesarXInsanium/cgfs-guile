(define-module (cgfs viewport))

(use-modules (cgfs math)
             (cgfs vec)
             (cgfs camera))


(use-modules (srfi srfi-9)
             (srfi srfi-9 gnu))

(define-record-type viewport
  (make-viewport distance width height)
  viewport?
  (distance vport-distance)
  (width vport-width)
  (height vport-height))

(define-public (canvas->vpcoord w h vp coord)
  (make-vec3 (* (car coord)
                (/ (vport-width vp)
                   w))
             (* (cdr coord)
                (/ (vport-height vp)
                   h))
             (vport-distance vp)))


(export make-viewport
        viewport?
        vport-width
        vport-height
        vport-distance)
