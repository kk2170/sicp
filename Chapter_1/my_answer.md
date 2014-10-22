#問題1.1
```
> 10
10
> (+ 5 3 4)
12
> (- 9 1)
8
> (/ 6 2)
3
> (+ (* 2 4) (- 4 6))
6
> (define a 3)
> (define b (+ a 1))
> (+ a b (* a b))
19
> ( = a b)
#f
> (if (and (> b a)(< b (* a b)))
      b
      a)
4
> (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
16
> (+ 2 (if (> b a) b a))
6
>(* (cond ((> a b) a)
           ((< a b) b)
           (else -1))
     (+ a 1))
16
```

#問題1.2
```
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))
```
#問題1.3
力技

```
(define (square a) (* a a))
(define (sum-of-squre-bigger-two-variable a b c)
  (cond ((and (> a b)(> c b))(+ (square a)(square c)))
        ((and (> a c)(> b c))(+ (square a)(square b)))
        ((and (> b a)(> c a))(+ (square b)(square c)))
        ))
```
#問題1.4
```
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```
問題なく実行が出来た。実行結果は以下のとおり
```
> (a-plus-abs-b 1 2)
3
> (a-plus-abs-b 1 -1)
2
```
まず(if (> b 0) + -)をcと置き換えて考える。
```
(define (c b)(if (> b 0) + -))
(define (a-plus-abs-b a b)
  ((c b) a b))
```
a-plus-abs-b内の式では、(c b)という演算子を用いてaとbを評価している。先に(c b)がbの値によって評価され演算子+または-が返り、その後その演算子と引数aとbを用いて最終的な評価が行われる。
#問題1.5
作用的順序では、引数の評価が先に行われるので(p)が評価される。関数pは停止条件が無い再帰なので無限ループに陥る。

正規順序では、関数の評価が行われるのでtestが先に評価され、xが0のため、0が帰ってくる。

RacketのRSR5では作用的順序で行われているようで(p)が先に評価されるため無限ループになった。