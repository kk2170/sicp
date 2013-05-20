;accumulate
(define (accumulate op initial sequence)
  (if (null? sequence )
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;Q2.33
(define (my-map p sequence)
  (accumulate (lambda(x y)(x) nil sequence)))

(define (my-append seq1 seq2)
  (accumulate cons seq1 seq2))

(define (my-length sequence)
  (accumulate  0 sequence))

;(my-map * (list 1 2 3))
(my-append (list 1 2 3) (list 1 2 3))
(my-length (list 1 2 3))