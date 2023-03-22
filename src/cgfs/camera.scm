(define-module (cgfs camera))

(use-modules (cgfs math)
             (cgfs vec))


(use-modules (srfi srfi-9)
             (srfi srfi-9 gnu))

(define-record-type camera
  (make-camera pos up at)
  camera?
  (pos camera-pos)
  (up camera-up)
  (at camera-at))

(export make-camera
        camera?
        camera-pos
        camera-up
        camera-at)
