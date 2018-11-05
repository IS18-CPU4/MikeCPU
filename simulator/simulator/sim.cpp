#include <iostream>
#include <string>
#include <vector>
#include <stdio.h>
#include <cstdlib>
#include <stdint.h>
#include <getopt.h>
#include <arpa/inet.h>
#include <algorithm>
#include "op.h"

#define INST_ADDR 0x10000
#define DATA_ADDR 0x10000

using namespace std;
void PrintHelp() {
	cout << "--step:   execute by step\n"
					"--help:	 show help\n"
					"put 1 input file name...\n";
	exit(1);
}
int step();
int normal();
bool stepflag = 0;
void ProcessArgs(int argc, char** argv) {
	const char* const short_opts = "h:";
	const option long_opts[] = {
		{"step", no_argument, nullptr, 's'},
		{"help", no_argument, nullptr, 'h'},
		{nullptr, no_argument, nullptr, 0}
	};
	while (1) {
		int opt = getopt_long(argc, argv, short_opts, long_opts, nullptr);
		if (-1 == opt) {break;}
		switch (opt) {
		case 's':
			stepflag = 1;
			break;
		case 'h':
		case '?':
			PrintHelp();
			break;
		default:
			break;
		}
	}
}


vector<uint32_t> GPR(32, 0);//汎用レジスタ
vector<float> FPR(32, 0.0);//浮動小数点レジスタ

uint32_t CR = 0;//コンディションレジスタ
//CR0~CR7の8個の4bitフィールド

uint32_t LR = 0;//リンクレジスタ
uint32_t CTR = 0;//カウントレジスタ
uint32_t INST_MEM[INST_ADDR] = {};//命令のバイナリを読み込むエンディアンに注意!

uint32_t DATA_MEM[DATA_ADDR] = {};//データを保存するメモリ

uint32_t PC;
uint32_t OP;

int lastPC;
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
			cout << hex << *itr << dec <<  ", ";}\
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
#define SHOWPC() cout << hex << (PC<<2) << dec << endl
#define SHOWOP() cout << hex << OP << dec << endl

void initialize() {
	cout << "initialization..." << endl;
	while(1){
		cout << "which register to set value? put char...GPR--g, FPR--f, end--e" << endl;
		char x;
		cin >> x;
		switch(x) {
		case 'g':
			while (1) {
				cout << "put index of GPR...put 0 to end setting" << endl;
				int index;
				cin >> index;
				if (0 == index) {break;}
				cout << "put value of GPR[" << index << "]: ";
				uint32_t value;
				cin >> value;
				GPR[index] = value;
			}
			cout << "end setting GPR" << endl;
			SHOWGPR();
			break;
		case 'f':
			while (1) {
				cout << "put index of FPR...put 0 to end setting" << endl;
				int index;
				cin >> index;
				if (0 == index) {break;}
				cout << "put value of FPR[" << index << "]: ";
				float value;
				cin >> value;
				FPR[index] = value;
			}
			cout << "end setting FPR" << endl;
			SHOWFPR();
			break;
		case 'e':
			cout << "end initialization..." << endl;
			return;
		default:
			cout << "undefined...try again." << endl;break;
		}
	}
}

void debug() {
	cout << "which to show? put char..." << endl;
	while (1) {
		cout << "GPR 'g', FPR 'f', CondR 'c', LinkR 'l', PC 'p', operation 'o', end 'e'" << endl;
		char x;
		cin >> x;
		switch(x) {
		case 'g':
			SHOWGPR();break;
		case 'f':
			SHOWFPR();break;
		case 'c':
			SHOWCR();break;
		case 'l':
			SHOWLR();break;
		//case 4:
		//	SHOWCTR();break;
		case 'p':
			SHOWPC();break;
		case 'o':
			SHOWOP();break;
		case 'e':
			return;
		default:
			cout << "undefined...try again" << endl;break;
		}
	}
}

int normal() {
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
	return 0;
}

int step() {
	cout << "execute by step..." << endl;
	PC = 0;
	GPR[1] = 0x8000;//stack
	//uint32_t breakpoint = 0;
	vector<uint32_t> breakpoint;
	vector<uint32_t>::iterator bitr;
	string str_pc;
	int bi;
	uint32_t nxtOP;
	while(PC < lastPC) {
		bool next = 0;
		while (!next) {
			cout << "(step) put 'h' for help...";
			char x;
			cin >> x;
			switch (x) {
			case 'n':
				next = 1;
				break;
			case 'b':
				cout << "set breakpoint...current PC is " << hex << (PC << 2) <<dec << endl;
				cout << "current breakpoint is..." << endl;
				for (bitr = breakpoint.begin(), bi = 0; bitr != breakpoint.end(); bitr++, bi++) {
					cout << "breakpoint " << dec << bi << ": "<< hex  << (*bitr << 2) << dec << endl;
				}
				cout << "put PC in hex you want to make breakpoint (put e to end): ";
				cin >> str_pc;
				if (str_pc== "e") {
					break;
				} else {
					try {
						while (1) {
							int int_pc= stoi(str_pc, nullptr, 0);
							if (int_pc % 4 != 0) {
								cout << "address is aligned by 4...try again" << endl;
								continue;
							}
							cout << "breakpoint PC = " << hex<< int_pc<< dec << endl;
							breakpoint.push_back(int_pc>> 2);
							break;
						}
					}catch (const invalid_argument& e) {
						cout << "invalid_argument...try again." << endl;
					}
				}
				break;
			case 'r':
				cout << "run to breakpoint" << endl;
				while (PC < lastPC) {
					bitr = find(breakpoint.begin(), breakpoint.end(), PC);
					if (bitr != breakpoint.end()) {
						breakpoint.erase(bitr);
						break;
					}
					int result = do_op();
					if (result) {
						cerr << "error at PC:" << hex << (PC << 2) << dec << endl;
						cerr << "move to debug mode" << endl;
						debug();
						return EXIT_FAILURE;
					}
				}
				if (PC >= lastPC) {
					cout << "reached end of execution" << endl;
					return 0;
				}else {
					cout << "reached breakpoint" << endl;
				}
				break;
			case 'g':
				SHOWGPR();break;
			case 'f':
				SHOWFPR();break;
			case 'c':
				SHOWCR();break;
			case 'l':
				SHOWLR();break;
			case 'i':
				cout << "next PC: ";
				SHOWPC();
				nxtOP = htonl(INST_MEM[PC]);
				cout << "next OP: " << hex << nxtOP << dec << endl;
				break;
			case 'm':
				while (1) {
					cout << "check data mem...put address of mem in hex (put e to end): ";
					string address;
					cin >> address;
					if (address == "e") {
						break;
					} else {
						try {
							int int_add = stoi(address, nullptr, 0);
							cout << "DATA_MEM[" << hex<< address << "] = " << DATA_MEM[int_add] << dec << endl;
						}catch (const invalid_argument& e) {
							cout << "try again." << endl;
						}
					}
				}
				break;
			case 's':
				cout << "stack pointer (GPR1) is: " << hex << GPR[1] << dec << endl;
				while (1) {
					cout << "check stack...put address of mem in hex (put e to end): ";
					string address;
					cin >> address;
					if (address == "e") {
						break;
					} else {
						try {
							int int_add = stoi(address, nullptr, 0);
							cout << "DATA_MEM[" << hex << address << "] = " << DATA_MEM[int_add] << dec<< endl;
						}catch (const invalid_argument& e) {
							cout << "try again." << endl;
						}
					}
				}
				break;
			case 'q':
				return EXIT_FAILURE;
			case 'h':
				cout << "'n'			next step" << endl
						<< "'b'			set breakpoint" << endl
						<< "'r'			run to breakpoint" << endl
						<< "'g'			show GPRs" << endl
						<< "'f'			show FPRs" << endl
						<< "'c'			show condition register" << endl
						<< "'l			show link register" << endl
						<< "'i'			show next PC and next operation" << endl
						<< "'m'			check data memory" << endl
						<< "'s'			check stack" << endl
						<< "'h'			show help" << endl
						<< "'q'			exit" << endl;
				break;
			default:
				cout << "undefined...look help.";
				break;
			}
		}

		int result = do_op();
		if (result) {
			cerr << "error at PC:" << hex << (PC << 2) << dec << endl;
			cerr << "move to debug mode" << endl;
			debug();
			return EXIT_FAILURE;
		}
	}
	return 0;
}
int main(int argc, char**argv) {
	/*if (argc != 2) {
		cerr << "invailed argument: did you specified input file?" << endl;
		return EXIT_FAILURE;
	}*/

	ProcessArgs(argc, argv);

	FILE* binary;

	cout << "opening binary file..." << endl;
	binary = fopen(argv[optind], "rb");
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
	lastPC = pos;
	fclose(binary);
	cout << "end reading!" << endl;
	
	initialize();

	cout << "start execution..." << endl;

	int result;
	if (stepflag == 1) {
		result = step();
	} else {
		result = normal();
	}
	if (!result) {
		cout << "finish execution! return value: " << endl;
		cout << "GPR[3]:" << hex << GPR[3]<< " FPR[1]:" << FPR[1] <<  hex << endl;
		debug();
	}
}
