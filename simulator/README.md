simulator

powerpcの命令セットを参考にしたオリジナルの命令セットをシミュレートする

/simulatorにおいてsimulatorとassemblerを一括でmakeできる。
simulator: /simulator/simulatorでmake 実行方法 ./sim --option [inputfile]    (optionはなしで普通の実行。現状optionはstepとhelpのみ)
assembler: /simulator/assemblerでmake 実行方法 ./asm [inputfile] [outputfile]

stackはデータメモリのアドレスが大きい場所を使っているので注意。
stackpointerは初めGPR[3]に0x8000がはいっている。
GPR[0]には書き込まないように。
GPR[3]はスタックポインタとして使う。
計算が終わったあとのデフォルトの返り値はGPR[1]かFPR[1]。それ以外はレジスタの中身をみる。

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

10/29
高速化について
OP関連の関数をOPクラスの関数オブジェクトに変更する
constをつけられるところにつけてわかりやすくする
例外処理
ループの条件を調整
コンパイル時の最適化

10/30
コメントによってラベルのアドレスがずれていたので修正
breakpointを設定できるようにしたが、いまのところPCでの指定のみ

11/6
breakpointを複数設定できる
bcondを修正
ha(label), lo(label)が読める

regのinitializationで不適切な入力をいれたとき無限ループになるのを修正
mincaml/powerpcの規約に合わせてtest用の.sファイルとsimulatorを調整

bcondで相対アドレスが負のとき違うアドレスに飛んでしまうのを修正
ba, balを追加

assembler の出力の1行目に実行する機械語列のバイト数
									2行目に_min_caml_startラベルの示すアドレスを追加　ラベルがない場合0になる
simulatorでは_min_caml_startラベルのアドレスから命令を実行する

