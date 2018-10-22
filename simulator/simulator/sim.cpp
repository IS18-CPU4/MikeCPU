#include <iostream>
#include <string>
#include <vector>
#include <stdio.h>
#include <cstdlib>
#include <stdint.h>
#include "op.h"

#define INST_ADDR 0x10000
#define DATA_ADDR 0x10000

using namespace std;

vector<uint32_t> GPR(32, 0);//汎用レジスタ
vector<float> FPR(32, 0.0);//浮動小数点レジスタ

uint32_t CR = 0;//コンディションレジスタ
//CR0~CR7の8個の4bitフィールド

uint32_t LR = 0;//リンクレジス\タ
uint32_t CTR = 0;//カウントレジスタ
uint32_t INST_MEM[INST_ADDR] = {};//命令のバイナリを読み込むエンディアンに注意!

uint32_t DATA_MEM[DATA_ADDR] = {};//データを保存するメモリ

uint32_t PC;
uint32_t OP;

//bitを取り出す
/*static inline uint32_t bits(uint32_t inst, unsigned int i, unsigned int j) {
	return (inst & ((1 << (i+1)) - (1 << j))) >> j;
}*/
	
// レジスタに値を設定　引数などに使用
void initialize();
//debug用に各レジスタを出力する関数をつくる

void debug();

#define SHOWGPR()\
	do { \
		int num = 0;\
		vector<uint32_t>::iterator itr;\
		for (itr = GPR.begin(); itr != GPR.end(); itr++) {\
			cout << "GPR[" << hex <<  num << "]: " << dec;\
			num++;\
			cout << *itr <<  ", ";}\
		cout << endl;}\
	while (0)

#define SHOWFPR()\
	do { \
		int numf = 0;\
		vector<float>::iterator itr;\
		for (itr = FPR.begin(); itr != FPR.end(); itr++) {\
			cout << "FPR[" <<  hex <<  numf  << dec << "]: ";\
			numf++;\
			cout << *itr << ", ";}\
		cout << endl;}\
	while (0)

#define SHOWCR() cout << hex << CR << dec << endl
#define SHOWLR() cout << hex << LR << dec << endl
#define SHOWCTR() cout << hex << CTR << dec << endl
#define SHOWPC() cout << hex << PC << dec << endl
#define SHOWOP() cout << hex << OP << dec << endl
void initialize() {
	cout << "initialization..." << endl;
	while(1){
		cout << "which register to set value? put a number...GPR--0, FPR--1, end--2" << endl;
		int x;
		cin >> x;
		switch(x) {
		case 0:
			while (1) {
				cout << "put the index of GPR...put 0 to end setting" << endl;
				int index;
				cin >> index;
				if (0 == index) {break;}
				cout << "put the value of GPR[" << index << "]: ";
				uint32_t value;
				cin >> value;
				GPR[index] = value;
			}
			cout << "end setting GPR" << endl;
			SHOWGPR();
			break;
		case 1:
			while (1) {
				cout << "put the index of FPR...put 0 to end setting" << endl;
				int index;
				cin >> index;
				if (0 == index) {break;}
				cout << "put the value of FPR[" << index << "]: ";
				float value;
				cin >> value;
				FPR[index] = value;
			}
			cout << "end setting FPR" << endl;
			SHOWFPR();
			break;
		case 2:
			cout << "end initialization..." << endl;
			return;
		default:
			cout << "pls put 0~2" << endl;break;
		}
	}
}
		

void debug() {
	while (1) {
		cout << "which register to show? put a number...GPR--0, FPR--1, CR--2, LR--3, CTR--4; PC--5, OP--6, end--7" << endl;
		int x;
		cin >> x;
		switch(x) {
		case 0:
			SHOWGPR();break;
		case 1:
			SHOWFPR();break;
		case 2:
			SHOWCR();break;
		case 3:
			SHOWLR();break;
		case 4:
			SHOWCTR();break;
		case 5:
			SHOWPC();break;
		case 6:
			SHOWOP();break;
		case 7:
			return;
		default:
			cout << "pls put 0~7" << endl;break;
		}
	}
}

int main(int argc, char**argv) {
	if (argc != 2) {
		cerr << "invailed argument: did you specified input file?" << endl;
		return EXIT_FAILURE;
	}
	FILE* binary;

	cout << "opening binary file..." << endl;
	binary = fopen(argv[1], "rb");
	if (!binary) {
		cerr << "cannot open file" << endl;
		return EXIT_FAILURE;
	} 

	size_t cnt;
	size_t pos = 0;
	cout << "reading instruction..." << endl;
	while ((cnt = fread(&INST_MEM[pos], 4, 2048, binary))) {
		pos += cnt;
	} 
	int lastPC = pos;
	fclose(binary);
	cout << "end reading!" << endl;
	
	initialize();

	cout << "start execution..." << endl;
	PC = 0;
	GPR[1] = 0x8000;//stack
	while(PC < lastPC) {
		int result = do_op();
		if (result) {
			cerr << "error at PC:" << hex << (PC << 2) << dec << endl;
			cerr << "move to debug mode" << endl;
			debug();
			return EXIT_FAILURE;
		}
	}
	cout << "finish execution! return value: " << endl;
	cout << "GPR[3]:" << hex << GPR[3]<< << " FPR[1]:" << FPR[1] <<  hex << endl;
	debug();
}
