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
  (accumulate length 0 sequence))

;(my-map * (list 1 2 3))
;(my-append (list 1 2 3) (list 1 2 3))
;(my-length (list 1 2 3))

;Q2.34
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higer-terms)
               (+ this-coeff (* x higer-terms)))
                               
             0
             coefficient-sequence))
(horner-eval 2 (list 1 3 0 5 0 1))
;Q2.35
(define (count-leaves t)
  (accumulate +  0 (map 
                    (lambda (x)(cond ((null? x)0)
                                     ((not (pair? x))1)
                                     (else(count-leaves x))
                                   
                      ))t)))

  (count-leaves (list (list 1 2 ) (list 3 4 )))

;Q2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init(map +(car seqs)))
           (accumulate-n op init (map +(cdr seqs))))))
(define s (list (list 1 2 3) (list 4 5 6 ) (list 7 8 9 ) (list 10 11 12)))
(accumulate-n + 0 s)