# cpu-ex
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
一通りの命令とラベルは読めてる
.txt .align .globlなどの調整

予定
simulatorのdebugが終わり次第step実行等便利な機能を実装する

10/21
バイナリファイルみたいとき　
コマンドラインで> xxd ~.bin
vim で :%!xxd  戻すときは :%!xxd -r

10/22
命令列が割り当てられてるものはout以外動く(はず)
floatにloadがないので、simulatorのinitializationのステップで好きなレジスタにいれる。

10/26
--stepでstep実行
-h
基本的に16進数表記なので注意
step実行以外にも細かいところをいじった(initializationとかが多少やりやすくなってる)
命令追加はまだ


