;accumulate
(define (accumulate op initial sequence)
  (if (null? sequence )
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
;enumerate-interval
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1 )high))))
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
;今回の計算対象
(define mx (list (list 1 2 3 4)(list 4 5 6 6)(list 6 7 8 9)))
(define v (list 1 2 3 4))

;各行列の点を計算してくれる
(define (dot-product v w)
  (accumulate + 0 (map * v w )))

(define (matrix-*-vector m v)
  (map (lambda(x)(dot-product x v))  m))

(matrix-*-vector mx v )
;A (30 56 80)
;1+4+9+16=30  4+10+18+24=56  6+14+24+36=80

(define (transpose mat)
  (accumulate-n cons '()  mat))
(transpose mx)
;A ((1 4 6) (2 5 7) (3 6 8) (4 6 9))
;((1 2 3 4)(4 5 6 6)(6 7 8 9))が
;((1 4 6) (2 5 7 ) (3 6 8 ) (4 6 9 ))のようになれば良いので正解行列を書けばよく分かる

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(x)(matrix-*-vector cols x))m)))
(matrix-*-matrix mx mx)
;A ((27 33 39 43) (60 75 90 100) (82 103 124 138))
;
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

;filter
(define (filter predicate sequence)
  (cond ((null? sequence )'())
        ((predicate (car sequence))
         (cons(car sequence)
              (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
;prime
(define (prime? n)
  (= n (smallest-divisor n)))
;smallest-divisor
(define (smallest-divisor n)
  (find-divisor n 2))
;find-divisor 
(define (find-divisor n test-divisor)
  (cond ((>(square test-divisor) n)n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1 )))))

;P71-72
(define (flatmap proc seq)
        (accumulate append '() (map proc seq)))
(define (prime-sum? pair)
  (prime? (+ (car pair)(cadr pair))))
(define (make-pair-sum pair)
  (list (car pair)(cadr pair)(+(car pair)(cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map(lambda(j)(list i j))
                      (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))
(define (permutations s)
  (if (null? s)
      '()
      (flatmap (lambda (x)
                 (map (lambda (p)(cons x p ))
                      (permutations (remove x s))))
               s)))
(define (remove item sequence)
  (filter (lambda (x)(not (= x item)))
          sequence))
  
(prime-sum-pairs 10)

;Q2.40


;Q2.41


;Q2.42





