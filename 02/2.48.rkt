#lang racket
(define (make-segment start end)
  (cons start end))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))
(define (make-vect x y)
  (cons x y))

(define c(make-segment (make-vect 1 2)(make-vect 3 4)))

(start-segment c)
(end-segment c)