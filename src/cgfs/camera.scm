(define-module (cgfs camera))

(use-modules (cgfs math)
             (cgfs vec))


(use-modules (srfi srfi-9)
             (srfi srfi-9 gnu))

(define-record-type camera
  (make-camera pos up at)
  camera?
  (pos cam-pos)
  (up cam-up)
  (at cam-at))

(export make-camera
        camera?
        cam-pos
        cam-up
        cam-at)
