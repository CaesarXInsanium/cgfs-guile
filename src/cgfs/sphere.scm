(define-module (cgfs sphere))

(use-modules (cgfs math)
             (cgfs vec))


(use-modules (srfi srfi-9)
             (srfi srfi-9 gnu))

(define-record-type sphere
  (make-sphere radius pos color)
  sphere?
  (radius sphere-radius)
  (pos sphere-pos)
  (color sphere-color))

(export make-sphere
        sphere?
        sphere-radius
        sphere-pos
        sphere-color)
