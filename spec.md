# 4班 1st CPU

- PowerPCベースとする。
- instructionは32bit
- レジスタ番号、即値もろもろの値はすべてビッグエンディアンとする

## 命令セット
https://docs.google.com/spreadsheets/d/1sB6ALczeEdokObAyfrjhicz5ttxa6FRFPCWTvoEtuDA/edit?usp=sharing

## レジスタ

- 32bit整数が32本
- 単精度floatが32本
- いずれも0番レジスタは常に0が入っている(書き込み不可)

- 4bitのcontrolレジスタ cr0[0:3]
	- [Negative, Positive, Zero, (Reserved)]

- 32bit link register

- 32bit program counter


