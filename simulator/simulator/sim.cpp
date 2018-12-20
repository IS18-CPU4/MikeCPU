#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <stdio.h>
#include <cstdlib>
#include <stdint.h>
#include <getopt.h>
#include <arpa/inet.h>
#include <algorithm>
#include <climits>
#include <chrono>
#include "revAsm.h"
#include "op.h"
#include "sld.h"

using namespace std;
void PrintHelp() {
cout << "--step:   execute by step\n"
				"--help:	 show help\n"
				"--input: specify inputfile (.sld)\n"
				"put 1 input file name...\n";
exit(1);
}

int step();
int normal();
bool stepflag = 0;
bool inputflag = 0;
string sldname;

void ProcessArgs(int argc, char** argv) {
	const char* const short_opts = "h:";
	const option long_opts[] = {
		{"step", no_argument, nullptr, 's'},
		{"help", no_argument, nullptr, 'h'},
		{"input", required_argument, NULL, 'i'},
		{nullptr, no_argument, nullptr, 0}
	};
	while (1) {
		int opt = getopt_long(argc, argv, short_opts, long_opts, nullptr);
		if (-1 == opt) {break;}
		switch (opt) {
		case 's':
			stepflag = 1;
			break;
		case 'i':
			sldname = optarg;
			inputflag = 1;
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

const int INST_ADDR = 0x10000;
const int DATA_ADDR = 0x1000000;
uint32_t INST_MEM[INST_ADDR] = {};//命令のバイナリを読み込むエンディアンに注意!

uint32_t DATA_MEM[DATA_ADDR] = {};//データを保存するメモリ

uint32_t PC;
uint32_t OP;
uint32_t mincamlStart;

uint32_t lastPC;
//bitを取り出す
/*static inline uint32_t bits(uint32_t inst, unsigned int i, unsigned int j) {
return (inst & ((1 << (i+1)) - (1 << j))) >> j;
}*/

vector<uint32_t> uinput_vector;

// レジスタに値を設定　引数などに使用
void initialize();
//debug用に各レジスタを出力する関数をつくる

void debug();

long long int instNum;//何番目の命令か

vector<char> outChar;//outによる出力を保存しておく

const uint32_t initsp = 0x800000;//spの初期値

#define SHOWGPR()\
do { \
	int num = 0;\
	vector<uint32_t>::iterator itr;\
	for (itr = GPR.begin(); itr != GPR.end(); itr++) {\
		cout << "GPR[" <<  num << "]: ";\
		num++;\
		cout << hex << *itr << dec <<  ", ";}\
	cout << endl;}\
while (0)

#define SHOWFPR()\
do { \
	int numf = 0;\
	vector<float>::iterator itr;\
	for (itr = FPR.begin(); itr != FPR.end(); itr++) {\
		cout << "FPR[" << numf << "]: ";\
		numf++;\
		cout << *itr << ", ";}\
	cout << endl;}\
while (0)

void initialize() {//手動での初期化　後に消すかも
	string index;
	int intindex;
	int intvalue;
	cout << "------------initialization of registers-----------" << endl << endl;
	while(1){
		cout << "which register to set value? put char...GPR--g, FPR--f, end--e: ";
		char x;
		cin >> x;
		switch(x) {
		case 'g':
			while (1) {
				cout << "put index of GPR...put e to end setting: ";
				cin >> index;
				if ("e" == index) {break;}
				try {
					intindex = stoi(index, nullptr, 0);
					if (intindex == 0) {
						cout << "you cannot set value in GPR[0]" << endl;
						continue;
					}
					if (0 < intindex && intindex < 32) {
						cout << "put value of GPR[" << intindex << "]: ";
						string value;
						cin >> value;
						try {
							intvalue = stoi(value, nullptr, 0);
							GPR[intindex] = intvalue;
						} catch (const invalid_argument &e) {
							cout << "invalid input...try again." << endl;
						}
					} else {
						cout << "put 1~31" << endl;
					}
				} catch (const invalid_argument& e) {
					cout << "put 1~31" << endl;
				}
			}
			cout << "end setting GPR" << endl << endl;
			SHOWGPR();
			cout << endl;
			break;
		case 'f':
			while (1) {
				cout << "put index of FPR...put e to end setting: ";
				cin >> index;
				if ("e" == index) {break;}
				try {
					intindex = stoi(index, nullptr, 0);
					if (0 <= intindex && intindex < 32) {
						cout << "put value of FPR[" << intindex << "]: ";
						float value;
						for (cin >> value; !cin; cin >> value){
							cin.clear();
							cin.ignore();
							cout << "put float!" << endl << "value: ";
						}
						FPR[intindex] = value;
					} else {
						cout << "put 0~31" << endl;
					}
				} catch (const invalid_argument& e) {
					cout << "put 0~31" << endl;
				}
			}
			cout << "end setting FPR" << endl << endl;
			SHOWFPR();
			cout << endl;
			break;
		case 'e':
			cout << "end initialization..." << endl;
			return;
		default:
			cout << "undefined...try again." << endl;break;
		}
	}
}

void debug() {//レジスタの中身を見る
	cout << "------------debug----------" << endl;
	vector<char>::iterator citr;
	int charcount;
	while (1) {
		if (stepflag == 1) {
			cout << "which to show? put char..." << endl
						<< "GPR 'g', FPR 'f', CondR 'c', LinkR 'l', PC&operation 'i', out 'o', memory 'm', stack 's',  end 'e': , ";
		} else {
			cout << "which to show? put char..." << endl
						<< "GPR 'g', FPR 'f', CondR 'c', LinkR 'l', PC&operation 'i',  memory 'm', stack 's', end 'e': ";
		}
		char x;
		cin >> x;
		switch(x) {
		case 'g':
			cout << endl;SHOWGPR();cout << endl;break;
		case 'f':
			cout << endl;SHOWFPR();cout << endl;break;
		case 'c':
			cout << hex << CR << dec << endl;break;
		case 'l':
			cout << hex << LR << dec << endl;break;
		case 'i':
			cout << hex << (PC<<2) << dec << endl;
			cout << hex << OP << dec << endl;
			cout << "in mnemonic: "; rev_asm(OP);break;
		case 'o':
			if (stepflag == 1) {
				if (!outChar.empty()) {
					charcount = 0;
					for (citr = outChar.begin();citr != outChar.end();citr++) {
						cout << "out[" << charcount << "]: " << *citr << endl;
						charcount++;
					} 
				} else {
					cout << "no out" << endl;
				}
			} else {
				cout << "undefined...try again" << endl;
			}
			break;
		case 'm'://メモリを見る
			while (1) {
				cout << "check data mem...put address of mem in hex (put e to end): ";
				string address;
				cin >> address;
				if (address == "e") {
					break;
				} else {
					try {
						int int_add = stoi(address, nullptr, 0);
						if (!((0 <= int_add) && (int_add < DATA_ADDR))) {
							cout << "invalid address...try again." << endl;
						}else {
							cout << "DATA_MEM[" << hex<< address << "] = " << DATA_MEM[int_add] << dec << endl;
						}
					}catch (const invalid_argument& e) {
						cout << "try again." << endl;
					}
				}
			}
			cout << endl;
			break;
		case 's'://stackを見る
			cout << "stack pointer (GPR3) is: " << hex << GPR[3] << dec << endl;
			while (1) {
				cout << "check stack...put address of mem in hex (put e to end): ";
				string address;
				cin >> address;
				if (address == "e") {
					break;
				} else {
					try {
						int int_add = stoi(address, nullptr, 0);
						if (!((0 <= int_add) && (int_add < DATA_ADDR))) {
							cout << "invalid address...try again." << endl;
						}else {
							cout << "DATA_MEM[" << hex<< address << "] = " << DATA_MEM[int_add] << dec << endl;
						}
					}catch (const invalid_argument& e) {
							cout << "try again." << endl;
					}
				}
			}
			cout << endl;
			break;
		case 'e':
			return;
		default:
			cout << "undefined...try again" << endl;break;
		}
	}
}

int normal() {//通常実行
	instNum = 0;
	PC = mincamlStart >> 2;
	GPR[3] = initsp;//stack
	while(PC < lastPC) {
		try {
			int result = do_op();
			if (GPR[3] >= DATA_ADDR) {
				throw 1;
			
			}
			if (initsp < GPR[4]) {
				throw 2;
			}
			if (result) {
				throw 3;
			}
		} catch (int fError) {
			if (fError == 1) {
				cerr << "error: stack overflow " << endl;
				PC--;
			} else if (fError == 2) {
				cerr << "error: heap overflow " << endl;
				PC--;
			}
			cout << "error at PC:" << hex << (PC<<2) << dec << endl;
			cout << hex << OP << dec << endl;
			cout << "in mnemonic: "; rev_asm(OP);
			cerr << "the number of executed instructions: " << dec << instNum << endl;
			cerr << "move to debug mode..." << endl;
			return 1;
		}
		instNum++;
	}
	return 0;
}

int step() {//step実行
	instNum = 0;
	cout << "execute by step..." << endl;
	PC = mincamlStart >> 2;
	GPR[3] = initsp;//stack
	//uint32_t breakpoint = 0;
	vector<uint32_t> breakpoint_PC;
	vector<long> breakpoint_Inst;
	vector<uint32_t>::iterator bitr;
	vector<long>::iterator biitr;
	vector<char>::iterator citr;
	string str_pc,str_inst;
	uint32_t opname;
	int bi;
	int charcount;
	uint32_t nxtOP;
	while(PC < lastPC) {
		bool next = 0;
		while (!next) {//次のステップに進むかどうかをnextフラグで判断
			cout << "(step " << dec << instNum << ") put 'h' for help...";
			char x, y;
			cin >> x;
			switch (x) {
			case 'n'://次に進む
				next = 1;
				break;
			case 'b'://breakpointの設定
				cout << "set breakpoint...current PC is " << hex << (PC << 2) <<dec << endl;
				cout << "current breakpoint is..." << endl;
				for (bitr = breakpoint_PC.begin(), bi = 0; bitr != breakpoint_PC.end(); bitr++, bi++) {
					cout << "breakpoint PC" << dec << bi << " (hex): "<< hex  << (*bitr << 2) << dec << endl;
				}
				for (biitr = breakpoint_Inst.begin(), bi = 0; biitr != breakpoint_Inst.end(); biitr++, bi++) {
					cout << "breakpoint Inst" << dec << bi << " (dec): "<<  *biitr  << endl;
				}
				while(1) {
				cout << "choose which to set breakpoint by...PC 'p', number of instructions 'i' (put e to end): ";
				cin >> y;
				if (y == 'e') {
					break;
				} else if (y == 'p') {
					cout << "set breakpoint by PC..." << endl;
					cout << "put PC in hex you want to make breakpoint (put e to end): ";
						while (1) {
							cin >> str_pc;
							if (str_pc== "e") {
								break;
							} else {
								try {
									int int_pc= stoi(str_pc, nullptr, 0);
									if (int_pc % 4 != 0) {
										cout << "address is aligned by 4...try again" << endl;
										cin.clear();
										cin.ignore();
										cout << "put PC in hex you want to make breakpoint (put e to end): ";
										continue;
									}
									cout << "breakpoint PC = " << hex<< int_pc<< dec << endl;
										breakpoint_PC.push_back(int_pc>> 2);
										break;
								}catch (const invalid_argument& e) {
									cin.clear();
									cin.ignore();
									cout << "invalid_argument...try again." << endl;
									cout << "put PC in hex you want to make breakpoint (put e to end): ";
									continue;
								}
							}
						}//end while of PC breakpoint
						continue;
					} else if (y == 'i') {
						cout << "set breakpoint by the number of instructions..." << endl;
						cout << "put the number in dec you want to make breakpoint (put e to end): ";
						while (1) {
							cin >> str_inst;
							if (str_inst == "e") {
								break;
							} else {
								try {
									long long_inst= stol(str_inst, nullptr, 0);
									cout << "breakpoint INST = " << long_inst << endl;
										breakpoint_Inst.push_back(long_inst);
										break;
								}catch (const invalid_argument& e) {
									cin.clear();
									cin.ignore();
									cout << "invalid_argument...try again." << endl;
									cout << "put the number in dec you want to make breakpoint (put e to end): ";
									continue;
								}
							}
						}//end while of Inst breakpoint
					} else {
						cout << "put e to end" << endl;
						continue;
					}
				}//end while of breakpoint
				cout << endl;
				break;
			case 'r'://breakpointまで走る
				cout << "run to breakpoint" << endl;
				while (PC < lastPC) {
					bitr = find(breakpoint_PC.begin(), breakpoint_PC.end(), PC);
					if (bitr != breakpoint_PC.end()) {
						breakpoint_PC.erase(bitr);
						cout << "reached breakpoint PC" << endl;
						break;
					}
					biitr = find(breakpoint_Inst.begin(), breakpoint_Inst.end(), instNum);
					if (biitr != breakpoint_Inst.end()) {
						breakpoint_Inst.erase(biitr);
						cout << "reached breakpoint Inst" << endl;
						break;
					}
					try {
						int result = do_op();
						if (GPR[3] >= DATA_ADDR) {
						throw 1;
						}
						if (initsp < GPR[4]) {
							throw 2;
						}
						if (result) {
							throw 3;
						}
					} catch (int frError) {
						if (frError == 1) {
							cerr << "error: stack overflow " << endl;
							PC--;
						} else if (frError == 2) {
							cerr << "error: heap overflow " << endl;
							PC--;
						}
						cout << "error at PC:" << hex << (PC<<2) << dec << endl;
						cout << hex << OP << dec << endl;
						cout << "in mnemonic: "; rev_asm(OP);
						cerr << "the number of executed instructions: " << dec << instNum << endl;
						cerr << "move to debug mode..." << endl;
						return 1;
					}
					instNum++;
				}
				if (PC >= lastPC) {
					cout << "reached end of execution" << endl << endl;
					return 0;
				}
				break;
			case 'g':
				SHOWGPR(); cout << endl;break;
			case 'f':
				SHOWFPR();cout << endl;break;
			case 'c':
				cout << hex << CR << dec << endl;break;
			case 'l':
				cout << hex << LR << dec << endl;break;
			case 'i':
				cout << "next PC: ";
				cout << hex << (PC<<2) << dec << endl;
				nxtOP = htonl(INST_MEM[PC]);
				cout << "next operation is...: " << hex << nxtOP << dec << endl
						 << "in mnemonic...: "; rev_asm(nxtOP);
				cout << endl;
				break;
			case 'm'://メモリを見る
				while (1) {
					cout << "check data mem...put address of mem in hex (put e to end): ";
					string address;
					cin >> address;
					if (address == "e") {
						break;
					} else {
						try {
							int int_add = stoi(address, nullptr, 0);
							if (!((0 <= int_add) && (int_add < DATA_ADDR))) {
								cout << "invalid address...try again." << endl;
							}else {
								cout << "DATA_MEM[" << hex<< address << "] = " << DATA_MEM[int_add] << dec << endl;
							}
					}catch (const invalid_argument& e) {
							cout << "try again." << endl;
						}
					}
				}
				cout << endl;
				break;
			case 's'://stackを見る
				cout << "stack pointer (GPR3) is: " << hex << GPR[3] << dec << endl;
				while (1) {
					cout << "check stack...put address of mem in hex (put e to end): ";
					string address;
					cin >> address;
					if (address == "e") {
						break;
					} else {
						try {
							int int_add = stoi(address, nullptr, 0);
							if (!((0 <= int_add) && (int_add < DATA_ADDR))) {
								cout << "invalid address...try again." << endl;
							}else {
								cout << "DATA_MEM[" << hex<< address << "] = " << DATA_MEM[int_add] << dec << endl;
							}
						}catch (const invalid_argument& e) {
								cout << "try again." << endl;
						}
					}
				}
				cout << endl;
				break;
			case 'o'://out命令で出力されたものを表示
				if (!outChar.empty()) {
					charcount = 0;
					for (citr = outChar.begin();citr != outChar.end();citr++) {
						cout << "out[" << charcount << "]: " << *citr << endl;
						charcount++;
					} 
				} else {
					cout << "no out" << endl;
				}
				break;
			case 'q'://強制終了
				return EXIT_FAILURE;
			case 'h'://help
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
						<< "'o'			show last out" << endl
						<< "'h'			show help" << endl
						<< "'q'			exit" << endl;
				cout << endl;
				break;
			default:
				cout << "undefined...look help.";
				break;
			}//switch end
		}//end while(!next)
		cout << "PC: " << hex << (PC << 2) << endl;
		opname = htonl(INST_MEM[PC]);
		cout << "operation " << hex << opname  << dec << endl
				 << "in mnemonic...: "; rev_asm(opname);
		cout << endl;

		try {
			int result = do_op();
			if (GPR[3] >= DATA_ADDR) {
				throw 1;
			}
			if (initsp < GPR[4]) {
				throw 2;
			}
			if (result) {
				throw 3;
			}
		} catch (int fError) {
			if (fError == 1) {
				cerr << "error: stack overflow " << endl;
				PC--;
			} else if (fError == 2) {
				cerr << "error: heap overflow " << endl;
				PC--;
			}
			cout << "error at PC:" << hex << (PC<<2) << dec << endl;
			cout << hex << OP << dec << endl;
			cout << "in mnemonic: "; rev_asm(OP);
			cerr << "the number of executed instructions: " << dec << instNum << endl;
			cerr << "move to debug mode..." << endl;
			return 1;
		}
		instNum++;
	}
	return 0;
}

ofstream fileout;

int main(int argc, char**argv) {
	/*if (argc != 2) {
		cerr << "invailed argument: did you specified input file?" << endl;
		return EXIT_FAILURE;
	}*/

	ProcessArgs(argc, argv);


	FILE* binary;
	cout << "open input binary file..." << endl;
	binary = fopen(argv[optind], "rb");
	if (!binary) {
		cerr << "cannot open binary file" << endl;
		return EXIT_FAILURE;
	}
	if (inputflag == 1) {//deal with sld file
		cout << "optional input: " << sldname << endl;
		ifstream inputsld(sldname, ios::binary);
		if (!inputsld) {
			cerr << "cannot open sld file" << endl;
			return EXIT_FAILURE;
		}
		unsigned char buf;
		inputsld.read((char*)&buf, sizeof buf);
		while(!inputsld.eof()) {
			cout << (uint32_t)buf << endl;
			uinput_vector.push_back((uint32_t)buf);
			inputsld.read((char*)&buf, sizeof buf);
		}

	}//end dealing with sld file

	cout << "open output file..." << endl;
	if (optind + 1 == argc) {
		fileout.open("a.out", ios::out|ios::trunc);
	} else if (optind + 2 == argc) {
		fileout.open(argv[optind+1], ios::out|ios::trunc);
	}
	if (!fileout) {
		cerr << "cannot open outputfile" << endl;
		return 1;
	}


	//機械語の読み取り
	size_t cnt;
	size_t pos = 0;
	cout << "reading instruction..." << endl;
	uint32_t codeBytein, codeByte;
	uint32_t mincamlStartin;
	fread(&codeBytein, 4, 1, binary);
	codeByte = htonl(codeBytein);
	cout << "byte of code: " << hex << codeByte << dec << endl;
	fread(&mincamlStartin, 4, 1, binary);
	mincamlStart = htonl(mincamlStartin);
	cout << "_min_caml_start label address: " << hex << mincamlStart << dec << endl;
	while ((cnt = fread(&INST_MEM[pos], 4, 2048, binary))) {
		pos += cnt;
	} 
	lastPC = pos;
	fclose(binary);
	cout << "end reading!" << endl << endl;//読み取り終わり
	
	GPR[3] = 0x8000;
	initialize();
	cout << endl;

	cout << "-----------start execution----------" << endl << endl;
	vector<char>::iterator citr;

	int ex_result = 0;

	if (stepflag == 1) {
		ex_result = step();
		if (ex_result == 0) {
			cout << "finish execution successfully!" << endl << endl;
			cout << "return value is... GPR[1]:" << hex << GPR[1]<< dec << " FPR[0]:" << FPR[0] << endl;
			cout << "the total number of instructions is (dec) : " << dec << instNum << endl;
			cout << endl;
			if (!outChar.empty()) {
				for (citr = outChar.begin(); citr != outChar.end(); citr++) {
					fileout << *citr;
				}
			}
			debug();
		} else {
			debug();
		}
	} else {
		chrono::system_clock::time_point start, end;
		start = chrono::system_clock::now();
		ex_result = normal();
		if (ex_result == 0) {
			end = chrono::system_clock::now();
			double elapsed = chrono::duration_cast<chrono::milliseconds>(end-start).count();
			cout << "finish execution successfully!" << endl << endl;
			cout << "execution time: " << elapsed << " milliseconds" << endl;
			cout << "return value is... GPR[1]:" << hex << GPR[1]<< dec << " FPR[0]:" << FPR[0] << endl;
			cout << "the total number of instructions is (dec) : " << dec << instNum << endl;
			cout << endl;
			/*if (!outChar.empty()) {
				for (citr = outChar.begin(); citr != outChar.end(); citr++) {
					fileout << *citr << " "  << endl;
				}
			}*/
			debug();
		} else {
			debug();
		}
	}
}
