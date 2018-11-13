#include <iostream>
#include <stdint.h>
#include <string>
#include <fstream>
#include <vector>
#include <sstream>
#include <arpa/inet.h>
#include <unordered_map>
#include "encode.h"
#include "opAsm.h"



using namespace std;

string trim(const string&, const char*);
uint32_t encode(const string);
uint32_t PC = 0;
extern unordered_map<string, uint32_t> labelMap;
extern vector<string> StringSplit(const string,const char);
extern uint32_t encode_to_op(vector<string>);

string trim(const string& str, const char* trimCharacterList = "\t\v\r\n") {
	string result;
	string::size_type left = str.find_first_not_of(trimCharacterList);

	if (left != string::npos) {
		string::size_type right = str.find_last_not_of(trimCharacterList);
		result = str.substr(left, right-left+1);
	}
	return result;
}

uint32_t encode(string str) {
	string trimmedStr = trim(str);
	vector<string> vitem;
	vector<string> vitem1 = StringSplit(trimmedStr, ' ');
	vector<string>::iterator itr;
	for (itr = vitem1.begin(); itr != vitem1.end(); itr++) {
		vector<string> vitem2 = StringSplit(*itr, ',');
		vector<string>::iterator itr2;
		for (itr2 = vitem2.begin(); itr2 != vitem2.end(); itr2++) {
			vitem.push_back(*itr2);
		}
	}
	uint32_t op = encode_to_op(vitem);
	return op;
}

int main(int argc, char** argv) {

	if (argc < 2) {
		cerr << "too few arguments put as follows: ./asm [inputfile] ([outputfile])" << endl;
		return 1;
	}
	
	cout << "open inputfile..." << endl;
	ifstream filein(argv[1]);
	cout << "open outputfile..." << endl;
	/*ofstream fileout(argv[2]);*/
	ofstream fileout;
	if (argc == 2) {
		fileout.open("out.bin", ios::out|ios::binary|ios::trunc);
	}
	if (argc == 3) {
		fileout.open(argv[2], ios::out|ios::binary|ios::trunc);
	}
	if (!fileout) {
		cerr << "cannnot open outputfile"  << endl;
		return 1;
	}

	uint32_t op;
	uint32_t codeByte = 0;
	uint32_t mincamlStart = 0;
	cout << "reading inputfile..." << endl;
	string line;
	//labelのset もっとよい方法がある気がする
	while (getline(filein, line)) {
		if (line == "") {
			continue;
		}
		string trimmedStr = trim(line);
		vector<string> vitem;
		vector<string> vitem1 = StringSplit(trimmedStr, ' ');
		vector<string>::iterator itr;
		for (itr = vitem1.begin(); itr != vitem1.end(); itr++) {
			vector<string> vitem2 = StringSplit(*itr, ',');
			vector<string>::iterator itr2;
			for (itr2 = vitem2.begin(); itr2 != vitem2.end(); itr2++) {
				vitem.push_back(*itr2);
			}
		}
		if (vitem[0].find_first_of("#", 0) == 0) {
			continue;
		}
		if (vitem[0].find_first_of(".", 0) == 0) {
			continue;
		}
		if (vitem[0].find_last_of(':') == vitem[0].length()-1) {
			cout << "label: " << line << endl;
			vector<string> vtmp = StringSplit(vitem[0], ':');
			labelMap[vtmp[0]] = PC;
			if (vtmp[0] == "_min_caml_start") {
				mincamlStart = PC;
			}
			cout << "PC: "<<  hex << PC << dec << endl;
			continue;
		}
		PC += 4;
	}
	codeByte = PC;
	cout << "finish labeling!" << endl;
	filein.close();
	//labelの処理終わり
	cout << "codeByte: " << hex << codeByte << dec << endl;
	fileout.write((char*)&codeByte, sizeof(uint32_t));
	fileout.write((char*)&mincamlStart, sizeof(uint32_t));

	ifstream filein2(argv[1]);
	PC = 0;

	while (getline(filein2, line)) {
		//line の処理
		if (line == "") {
			continue;
		}
		cout << "deal with " << line << endl;
		op = encode(line);
		if (op == 0xFFFFFFFF) {
			return 1;
		}
		if (op == 0x00000000) {
			cout << "not operation" << endl;
			continue;
		}
		//simulator用にバイナリ出力に直す
		cout << hex << op << endl;
		/*fileout << hex << op << endl;*/
		uint32_t opout = ntohl(op);
		fileout.write((char*)&opout, sizeof(uint32_t));
		PC += 4;
	}
	cout << "finish reading!" << endl;

	filein2.close();

	fileout.close();

	return 0;
}


