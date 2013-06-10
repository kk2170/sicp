
;Q2.21
(define (square-list1 items)
  (if (null? items)
      '()
      (cons (*(car items)(car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
  (map (lambda (x) (* x x )) items))
(square-list1 (list 1 2 3 4 ))
(square-list2 (list 1 2 3 4))

;Q2.22
(define (square x)
  (* x x ))
(define (square-list3 items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons (square (car things))
		    answer))))
  (iter items '()))
(square-list3 (list 1 2 3 4 5))
;こちらはcdrが先にする来るような形で実行を行なっているため
(define (square-list4 items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons answer
		    (square (car things))))))
  (iter items '()))
(square-list4 (list 1 2 3 4 5))
;こちらは何も考えず逆につないだ結果、consの性質で発生した。
;Q.23
(define (my-for-each x y)
  (cond 
    ((null? y)#t)
    (else(x (car y))(my-for-each x (cdr y)))))
(my-for-each (lambda (x ) (newline) (display x))(list  57 321 88))
(my-for-each (lambda (x ) (newline) (display x))'())

;Q2.24

;Q2.25
(car(cdr(car(cdr (cdr (list 1 3 (list 5 7 ) 9))))))
(car(car(list(list  7)) ))
(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(list 1 (list 2 (list 3 (list 4(list 5(list 6 7)))))) ))))))))))))

;Q2.26
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y)
(cons x y)
(list x y)

;(1 2 3 4 5 6)
;((1 2 3) 4 5 6)
;((1 2 3) (4 5 6))

;Q2.27
(define (deep-reverse x)
  (cond
    ((null? x) x)
    ((list? (car x))(append (deep-reverse(cdr x))(deep-reverse(car x))))
    (else  (list(reverse x)))
    )
  )
(deep-reverse (list (list 1 2 ) (list 3 4)))
;Q-2.28
;力技
(define (fringe x)
  (if (not (pair? x))
      x
      (fringe-x (car x) (cdr x))))

(define (fringe-x x y)
  (if(null? y)
     (if(pair? x)
        (fringe-x (car x) (cdr x))
        (cons x'())
        )
     (if(pair? x)
       (fringe-x (car x) 
                 (if (null? (cdr x))
                     y 
                     (cons (cdr x) y)))
        (cons x (fringe-x (car y)(cdr y) )))))
          

;(cons 1 (cons 2 ( cons 3 '())))
(define x (list (list 1 2 ) (list 3 4)))
;(car (list x x))
;(fringe-r '() '())
;(fringe-r (list x ) '())
(fringe x)
(fringe (list x x))

;Q-2.29
;A carとcadrで取れる
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
;B 
(define (total-weight mobile)
  (if (list? mobile)
      (+(total-weight (car mobile) )(total-weight (cadr mobile)))
      mobile))
;C
(define (balance mobile)
 (if (=(total-weight (car mobile))(total-weight (cadr mobile)))
     (if (list? mobile)
         (and (blance (car mobile))(balance(cdr mobile)))
         #t)
     #f))
         
;D 変更必要ない
;Q-2.30
(define (square-tree x)
  (map (lambda (y)
           (if(pair? y)
              (square-tree y)
              ( * y y  )
           ))
       x))


;Q-2.31
(define (tree-map x y)
  (map (lambda (sub-y)
         (if (pair? sub-y)
             (tree-map x sub-y)
             (x sub-y)
             ))y))

(define (square x)
  (* x x ))
;Q-2.32
(define (subsets s)
  (if(null? s)
     (list '())
     (let((rest (subsets(cdr s))))
      (append rest (map (lambda (a) (cons (car s) a)) rest)))))
 (subsets (list 1 2 3 ))
 (subsets '())
;理由
;最初に、(list '())まで実行が進み、restに束縛される。
;restにmapで各リストをrestにcons適用していく。
;その結果とそれ以前の結果をアペンドすることで実現されている。
