simulator

-----------------------------基本情報----------------------------------------

powerpcの命令セットを参考にしたオリジナルの命令セットをシミュレートする
/simulatorにおいてsimulatorとassemblerを一括でmake, cleanできる。


simulator: 下のassemblerの出力であるバイナリファイルを読み込み命令をシミュレートする。

/simulator/simulatorでmake 
実行方法 ./sim --option [inputfile] [outputfile]

optionなしで普通の実行。現状optionはstepとhelpのみ。
--stepでstep実行
-h, --helpでhelp

out命令の出力がoutputfileに出力される。アスキーコードで変換済み。
上のoutputfileを指定しない場合a.outに出力される。

step実行時のコマンドはhで確認できる。
(step 累計命令数)という表示。

_min_caml_start ラベルの位置から実行を開始する。

simulatorのinitializationのステップで手動でレジスタの値を初期化できる。(この機能は消すかも)

make clean でa.outというファイルは消される。



assembler:コンパイラが出力する.sファイルを読み込んで,対応する機械語をバイナリファイルに出力する。

/simulator/assemblerでmake
実行方法 ./asm [inputfile] [outputfile]

outputfileを指定しない場合out.binに出力される。

PCが行頭に追加されたアセンブリがasm_with_PC.outとして出力される。

.sファイルのコメント #開始で、1行に渡ってことが可能。
出力の先頭２行はバイト数、_min_caml_startの位置


tabを読めないのでコンパイラからの出力ファイルをつかうときはsed 's/\t/ /g' [タブありfile名] > [タブなしfile名]
⇑　tabが読めるようになった。



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

実行結果を画像で出すなら
P1 400 400 を先頭につける

----------------------------重要な更新と直近の更新----------------------------------------------

11/17
step実行のみout命令による出力を保存するようにし、普通に実行した場合はout命令が呼ばれた段階で出力ファイルに出すようにした。

命令数を long long intにしたのでとりあえず大丈夫。

やっとアセンブラでtabが読めるようになった(多分）

11/28
シミュレータ上で負の値をレジスタから読むときの挙動がよくなかったので直した。

11/29
アセンブラを使ったとき元のアセンブリ(入力)にPCを行頭につけたファイルasm_with_PC.outを生成するようにした。

12/2
fadd fsub ok
fmul ok
finv  fdiv ok
ftoi itof ok

---------------------------------------タスク------------------------------------------------------

.txt .align .globlなどの調整

bcの修正

(リンカ)
