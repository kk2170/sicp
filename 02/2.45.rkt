#lang racket
(define (split first second)
  (define (split-operation painter n)
    (if (= n 0)
        painter
        (let((smaller(split-operation painter (- n 1))))
          (first painter(second smaller smaller)))))
  split-operation)