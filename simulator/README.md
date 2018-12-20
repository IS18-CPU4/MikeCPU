simulator

-----------------------------基本情報----------------------------------------

powerpcの命令セットを参考にしたオリジナルの命令セットをシミュレートする
/simulatorにおいてsimulatorとassemblerを一括でmake, cleanできる。


simulator: 下のassemblerの出力であるバイナリファイルを読み込み命令をシミュレートする。

/simulator/simulatorでmake 
実行方法 ./sim --option [inputfile] [outputfile]

optionなしで普通の実行。現状optionはstepとhelpのみ。
--stepでstep実行
--input in命令に使う入力ファイル(バイナリ)を選ぶ
-h, --helpでhelp

実行例 ./sim --input sld/contest.bin --step out.bin contest.out

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


共通:
どちらのディレクトリでもout.binという名前のファイルはmake cleanで消える。

基本的に16進数表記。(dec)とついてるものだけが10進

stack
	stackはデータメモリのアドレスが大きい場所を使っているので注意。
	stackpointerは初めGPR[3]に0x8000がはいっている。
	12/19:0x800000になった
	GPR[3]はスタックポインタとして使う。

GPR[0]には書き込まないように。
計算が終わったあとのデフォルトの返り値はGPR[1]とFPR[1]。それ以外はレジスタの中身をみる。

バイナリファイルをみたいとき　
	コマンドラインで> xxd ~.bin
	vim で :%!xxd  戻すときは :%!xxd -r

実行結果を画像で出すなら
P1 サイズ　サイズ を先頭につける

----------------------------重要な更新と直近の更新----------------------------------------------

12/2, 12/3
float命令をfpu係の実装に合わせる作業
							実装      テスト
fadd					 ok				 ok
fsub					 ok				 ok
fmul					 ok				 ok
finv					 ok				 ok
fdiv					 ok				 ok
ftoi					 ok
itof					 ok
fsqrt					 ok				 ok

12/12
LRにPCをちゃんと保存していなかったので、balで死んでいた
iｎ命令は死んでいそう
in命令は２つ続きのスペースを読めていなかっただけのよう

12/19
sld_converterを使うことになった。
sldファイルの読み込みの際、simulator/sld/ でmakeして、./sld_converter test.sld test.txt test.bin
とすることで、この時生成されるバイナリファイルをつかう。
それにともなってin命令とsldの読み込みを修正した。
実行例
compiler/min-caml-master　で
> make bc
> ./min-caml -global shootout/minrt
> cp ./shootout/minrt.s ../../simulator/assembler/test/
simulator/でmake
simulator/assembler で
> ./asm ./test/minrt.s
> cp out.bin ../simulator
simulator/simulator で
> ./sim --input sld/contest.bin out.bin

contest.sldが動いて、命令数65億、実行時間60sec

---------------------------------------タスク------------------------------------------------------

float
