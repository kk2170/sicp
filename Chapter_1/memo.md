#1 手続きによる抽象の構築
計算プロセスとは、dataを操作する抽象的な存在であり、プロセスに指示をするためにプログラムを作成する。
プログラムはプログラム言語の記号式で構成されている。

Lispによるプログラム
プロセスを記述するような手頃な記述言語としてLispを用いる。
Lispは1950年ごろに計算のモデルである再帰方程式という論理表現についての推論の形式化として発明されたものである。
論文は[これ](http://www-formal.stanford.edu/jmc/recursive.pdf)。

本書ではSchemeという方言を用いる。

##1.1 プログラムの要素


   * 基本式 ・・・言語が関わるもっとも単純なもの
   * 組み合わせ法・・・より単純なものから合成物を作る
   * 抽象化法・・・合成物に名前をつけてひとつのものとして扱う

###1.1.1 式
プログラムを始めるときはインタープリターで簡単に評価を確認すると良い。
演算子を左側に置く記法を前置記法という。通常とは異なるが、以下の2点の利点を持つ

利点1 : 任意の引数をとる手続きを許すことが出来る。
```
 (+ 21 35 12 7)
```

利点2 : 入れ子にすることが許される

```
(+ (* 3 5)(- 10 6))
```

どのような処理に対しても解釈系はread-eval-print loopを回るので覚えておいて欲しい

###1.1.2 名前と環境

プログラム言語の重要な機能は名前を使って計算オブジェクトを指す手段を用意することである。
オブジェクトを値(value)とする変数(variable)を識別するものが名前である。

Lispの方言であるSchemeはdefineで名前をつける

```define
(define size 2)
```

と入力すると解釈系は値2と名前sizeをひもづける。一回名前を値と対応付けると名前で値を指すことが出来る。

```上記の場合
size
2    ;sizeが評価されて2が帰ってきている。
```

一般的に計算オブジェクトがとても複雑な構造を持っているとすれば、覚えてなきゃいけないとか、書き換えるときに大変だったりするので不便である。
なので、複雑なプログラムは、複雑さが増えるようなオブジェクトが徐々に増えるように組み上げていく。

値と記号を対応付け、それを取り出すために解釈系はその対応を忘れないため、記憶する必要がある。
この記憶を環境(enviroment : より正確にはこの場合大域変数(global enviroment))という。

###1.1.3 組み合わせの評価

この章の目的の一つは手続き的な考え方に注目すること。

組み合わせを評価するために次のことを行う:

* 組み合わせの部分式を評価する。
* 最左部分式の値である手続きを, 残りの部分式の値である引数に作用させる。

組み合わせの評価プロセスを達成するには、組み合わせの各要素の評価プロセスを行わなければならない。
故に、評価の規則は再帰的に行われる。

一般的に、再帰は階層的な木構造のオブジェクトを扱うのに強力な技法であることがわかる。
評価規則の「値が情報へ湧き出す」形は木構造の溜め込みとして知られている。

一つ目の規則を行っていると評価する必要の無い数字列,　基本演算子, またはそれ以外の名前のような,組み合わせでない基本的な式に至る。以下がその条件である。

* 数字列の値は数値とする
* 基本演算子の値は対応する演算を実行する機械命令の列とする
* それ以外の名前は、その環境で名前と対応付けられたオブジェクトとする


※注意 上記の評価規則は定義は扱わない。

```
(define x 2)
```
等の式では、defineの目的はxを2に対応付けただけなのでこれは組み合わせではない(らしい)

このような一般評価形式の例外を特殊形式という。

####1.1.4 合成手続き
今まで出てきたLispの性質
* 数と算術演算子は基本的データと手続きである
* 組み合わせの入れ子は演算を組み合わせる手段である
* 名前と値を対応付ける定義は抽象のそこそこの手段である

ここでは、手続き定義を学ぶ。これにより合成演算に名前を対応付けることが出来る。
手続き定義の一般形は

```
(define (<name> <formal parameters>)<body>)
```
である

###1.1.5 手続き作用の置き換えモデル
演算子が合成手続きの名前になっている場合評価するのに1.1.3で説明したような演算子が基本手続きになっている組み合わせとほとんど同じプロセスを踏む。

* 合成手続きを引数に作用させるには、各仮パラメタの対応する引数で取替,手続きの本体を評価する。

```
(define (square a) (* a a))
```
があるときに

```
(square 2)
```
を実行すると

```
(* 2 2)
```
に置き換えられて計算すると考えられる。これらは手続き作用の置き換えモデルという。

* ただし、これは人間が考えるためのモデルであって解釈系の実際の解釈と異なる場合もある。

####作用的順序と正規順序
* 正規順序の評価 : 手続きや関数を展開して評価をしていく
* 作用的順序の評価 : 引数を評価し作用させる


###1.1.6 条件式と述語
場合分けするための構文としてcondを使う。一般式は以下のとおり。

```
(cond (<p1> <e1>)
      (<p2> <e2>)
      ・
      ・
      (<pn> <en>))
```
上記のようにcondに続けて節というかっこに入った式の対(<p> <e>)を並べたものである。

pは述語と呼び。条件として扱われる。condはまず述語を評価し、p1から順に真偽値が真になるものが出てくるまで評価していく。真になった場合対応するeの値:帰結式　の評価値を返す。

if文, and, or, not などの構文も用意されている。

###1.1.7 例:Newton方による平方根