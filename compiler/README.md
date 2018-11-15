compiler

min-camlの作者のテロのせいで"EUC-JP"が文字コードです、、、
なおコンパイラ係がテロって一部の文字コードはUTF-8にしています

実行の仕方
--最初に--
$ git pull origin compiler
(compilerディレクトリに移動)
$ cd min-caml-master
$ ./to_cpucore

--コンパイルの仕方--
$ make
$ ./min-caml hoge

・make時にエラー吐くけど、ただ実行しようとして命令セットがあってないだけなので基本的には問題なし（要修正、Makefileをイジイジするだけ）
・・でも、もしコンパイルエラーを吐いたら文句言いに来てください
・hogeはソースコードの相対アドレスから.mlをとったもの・
・・例: test/fib.mlをコンパイルしたいなら
 $ ./min-caml test/fib
・アセンブリファイルはソースコードと同じディレクトリに吐かれる

--コンパイルオプション--
 $ ./min-caml -op hoge みたいに使う
・-iter n : n回(既存のmin-camlコンパイラに用意された)最適化を行う。使わない変数とか捨てられたり、割と適当なコードだと改変されるので、生のコードのままにして欲しいなら -iter 0 とすべき。デフォルトで -iter 1000している。
・-inline n : 最大サイズnまでinline展開する。
・-dump str : strに対応した途中結果を出力する strはs,k,a,cの結合文字列で以下を出力する
・・ s:Syntax.fを通した結果
・・ k:KNormal.fを通した結果
・・ a:Alpha.fを通した結果
・・ c:Cse.fを通した結果（共通部分式削除）
・・ たとえば、-dump kc とすればk,cに対応したものがそれぞれ出力される。
(※Cse.fがうまく動作してないので、-dumpオプションは使わないで)

--トラブルシューティング--
case1: make 通したのに コンパイルエラー吐いた
・コンパイル係を殴る
・行エラー（Error: no such instruction:）とかが出た場合は何も問題ありません

case2: CPUCore以下の中身を変更したのにmakeされない
・to_cpucore時のリンカの変更はmakeが何故か変更と認識しない（意味不明）
・・つまりCPUCore以下のhoge.mlをmin-caml-master以下のhoge.mlは同期され、
　CPUCore/hoge.mlを変更したらmin-caml-master以下のhoge.mlも変更されるけど、makeするときは変更前のhoge.mlが使われる
・要は $ make clean しましょう。

case3: pullしたはずなのにmakeが更新済みとかなった
・case2と同じ



--以下個人用--
libmincaml.Sの作り方（個人用、置換はatomでの機能）
①ライブラリを書くmlで書く
②コンパイルする
③アセンブリコードで
  ([^\s]*\.\d+)　を
  hoge_$1に置換する
