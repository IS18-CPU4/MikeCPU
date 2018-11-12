simulator

-----------------------------基本情報----------------------------------------

powerpcの命令セットを参考にしたオリジナルの命令セットをシミュレートする
/simulatorにおいてsimulatorとassemblerを一括でmake, cleanできる。



simulator: 
/simulator/simulatorでmake 実行方法 ./sim --option [inputfile]    (optionなしで普通の実行。現状optionはstepとhelpのみ)
--stepでstep実行
-h, --helpでhelp

step実行時のコマンドはhで確認できる。
(step 累計命令数)という表示。

_min_caml_start ラベルの位置から実行を開始する。

simulatorのinitializationのステップで手動でレジスタの値を初期化できる。(この機能は消すかも)



assembler: /simulator/assemblerでmake 実行方法 ./asm [inputfile] [outputfile]

.sファイルのコメント #開始で、1行に渡ってことが可能。
出力の先頭２行はバイト数、_min_caml_startの位置

tabを読めないのでコンパイラからの出力ファイルをつかうときはsed -E 's/\t+/ /g' [inputfile] > [outputfile]



共通:
どちらのディレクトリでもout.binという名前のファイルはmake cleanで消える。

基本的に16進数表記。(dec)とついてるものだけが10進

stack
	stackはデータメモリのアドレスが大きい場所を使っているので注意。
	stackpointerは初めGPR[3]に0x8000がはいっている。
	GPR[3]はスタックポインタとして使う。

GPR[0]には書き込まないように。
計算が終わったあとのデフォルトの返り値はGPR[1]とFPR[1]。それ以外はレジスタの中身をみる。

バイナリファイルをみたいとき　
	コマンドラインで> xxd ~.bin
	vim で :%!xxd  戻すときは :%!xxd -r

----------------------------重要な更新と直近の更新----------------------------------------------

11/6
bcondを修正
ha(label), lo(label)が読める

mincaml/powerpcの規約に合わせてtest用の.sファイルとsimulatorを調整

bcondで相対アドレスが負のとき違うアドレスに飛んでしまうのを修正
ba, balを追加

assembler の出力の1行目に実行する機械語列のバイト数
2行目に_min_caml_startラベルの示すアドレスを追加　ラベルがない場合0になる

simulatorでは_min_caml_startラベルのアドレスから命令を実行する



11/9
breakpoint(PC)のバグを直した。
実行された命令数が表示されるようにした。通常実行の場合は累計のみ、step実行の場合はstep時点での累計が表示される。

11/13
シミュレータでのstep実行の際ニーモニックが見れるようになった。branch系統の命令は相対アドレスなので注意。
シミュレータの表示を少し見やすくした。
コードを整理した。

---------------------------------------タスク------------------------------------------------------

.txt .align .globlなどの調整

高速化
	OP関連の関数をOPクラスの関数オブジェクトに変更する
	constをつけられるところにつけてわかりやすくする
	例外処理
	ループの条件を調整


bcの修正

実行時間の表示
