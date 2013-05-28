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
      `()
      (cons (accumulate op init(map (lambda(x)(car x))seqs))
           (accumulate-n op init (map (lambda(x)(cdr x)) seqs)))))
(define s (list (list 1 2 3) (list 4 5 6 ) (list 7 8 9 ) (list 10 11 12)))
(accumulate-n + 0 s)

;Q2.37

;Q2.38
; accumulateをfold-rightとして宣言
(define (fold-right op initial sequence)
  (if (null? sequence )
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;本の定義をそのまま
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest ))))
  (iter initial sequence))

(fold-right / 1 (list 1  2 3 ))
;A3/2 約分までするとは恐るべし・・・
;右から順番に評価されてる2/3  1/ (2/3) = 1* (3/2)

(fold-left / 1 (list 1 2 3 ))
;A 1/6
;左から順番に評価されてる(1/2)/3=1/6 

(fold-right list '() (list 1 2 3 ))
;A(1 (2 (3 ())))
; 右から評価されてる

(fold-left list '() (list 1 2 3 ))
;A (((() 1) 2) 3)
;左から評価されてる


;Q2.39

; reverse-lと同じ発想だけどこれじゃだめ
;(define (reverse-r sequence)
;  (fold-right (lambda (x y)(list y x )) '() sequence))
;(reverse-r (list 1 2 3 4))
; 結果 ((((() 4) 3) 2) 1)
; 後一手間いる
(define (reverse-r sequence)
  (fold-right (lambda (x y)(append y (cons x '()))) '() sequence))
(reverse-r (list 1 2 3 4))



;何となくconsでyとxを逆に繋げば良いと発想して作成
(define (reverse-l sequence)
  (fold-left (lambda (x y)(cons y x )) '() sequence))

(reverse-l (list 1 2 3 4))
;(4 3 2 1)