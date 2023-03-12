(define-module (cgfs viewport))

(use-modules (cgfs math)
             (cgfs vec))


(use-modules (srfi srfi-9)
             (srfi srfi-9 gnu))

(define-record-type viewport
  (make-vport pos width height)
  viewport?
  (pos vport-pos)
  (width vport-width)
  (height vport-height))

(define-public (canvas->vpcoord w h vp coord distance-from-camera)
  (make-vec3 (* (car coord))
             (/ (vport-width vp)
                w)
             (* (cdr coord)
                (/ (vport-height vp)
                   h))
             distance-from-camera))

(define-public (vport-cam-dist vp cam)
  (vdist (cam-pos cam)
         (vport-pos vp)))



(export make-vport
        viewport?
        vport-pos
        vport-width
        vport-height
        vport-distance)
