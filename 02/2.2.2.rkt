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
