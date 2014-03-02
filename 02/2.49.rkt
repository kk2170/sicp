#lang racket
(define (frame-painter frame)
  (segments->painter(list
                     (make-segment (make-vector 0.0 0.0)
                                   (make-vector 0.0 1.0))
                     (make-segment (make-vector 0.0 1.0)
                                   (make-vector 1.0 1.0))
                     (make-segment (make-vector 1.0 1.0)
                                   (make-vector 1.0 0.0))
                     (make-segment (make-vector 1.0 0.0)
                                   (make-vector 0.0 0.0)))))
(define (x frame)
  (segments->painter(list
                     (make-segment (make-vector 0.0 0.0)
                                   (make-vector 1.0 1.0))
                     (make-segment (make-vector 1.0 0.0)
                                   (make-vector 0.0 1.0)))))

(define (frame-painter frame)
  (segments->painter(list
                     (make-segment (make-vector 0.5 0.0)
                                   (make-vector 1.0 0.5))
                     (make-segment (make-vector 1.0 0.5)
                                   (make-vector 0.5 1.0))
                     (make-segment (make-vector 0.5 1.0)
                                   (make-vector 0.0 0.5))
                     (make-segment (make-vector 0.0 0.5)
                                   (make-vector 0.5 0.0)))))

(define (wave-painter frame)
  (segments->painter(list
                     (make-segment (make-vector 0.0 0.5)
                                   (make-vector 0.5 0.0))
                     (make-segment (make-vector 0.5 0.0)
                                   (make-vector 1.0 0.5))
                     (make-segment (make-vector 0.0 1.0)
                                   (make-vector 0.5 0.5))
                     (make-segment (make-vector 0.5 0.5)
                                   (make-vector 1.0 1.0)))))