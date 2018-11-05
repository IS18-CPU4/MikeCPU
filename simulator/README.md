simulator

powerpcの命令セットを参考にしたオリジナルの命令セットをシミュレートする

simulator: /simulatorでmake 実行方法 ./sim [inputfile]
assembler: /assemblerでmake 実行方法 ./asm [inputfile] [outputfile]

stackはデータメモリのアドレスが大きい場所を使っているので注意。
stackpointerは初めGPR[1]に0x8000がはいっている。
GPR[0]には書き込まないように。
GPR[1]はスタックポインタとして使う。
計算が終わったあとのデフォルトの返り値はGPR[3]かFPR[1]。それ以外はレジスタの中身をみる。

10/15
.txt .align .globlなどの調整

10/21
バイナリファイルみたいとき　
コマンドラインで> xxd ~.bin
vim で :%!xxd  戻すときは :%!xxd -r

10/22
floatにloadがないので、simulatorのinitializationのステップで好きなレジスタにいれる。
inttofloatでよくなった。

10/26
assembler:
追加された命令に対応
.sファイルにコメントを書けるようにした #開始で、1行に渡って書くことが可能。
errorがわかりやすくなった。

simulator:
追加された命令に対応
--stepでstep実行
-h, --helpでhelp
基本的に16進数表記なので注意
step実行以外にも細かいところをいじった(initializationとかが多少やりやすくなってる)
errorをわかりやすくする

インライン展開とかで高速化を目指す

10/28
outを追加
cmpとbcの調整:いまは32bit condregを4bitごとに8つに分割していて、cmp系統では8つのうちどれを使うかをcrDで指定 bcでは0~31のbitで指定する仕様

10/29
高速化について
OP関連の関数をOPクラスの関数オブジェクトに変更する
constをつけられるところにつけてわかりやすくする
例外処理
ループの条件を調整

10/30
コメントによってラベルのアドレスがずれていたので修正
breakpointを設定できるようにしたが、いまのところPCでの指定のみ

11/6
breakpointを複数設定できる
bcondを修正
ha(label), lo(label)が読める。
