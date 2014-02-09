#lang racket
(define(up-split2 painter n)
  (if(= n 0)
     painter
     (let((smaller(up-split2 painter(- n 1))))
       (below painter(beside smaller smaller)))))
((up-split2 wave4 5)frame)