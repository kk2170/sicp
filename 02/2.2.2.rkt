;Q-2.28

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
     (list )
     (let((rest (subsets(cdr s))))
       (append rest (map <??> rest)))))
;理由

;Q-2.33