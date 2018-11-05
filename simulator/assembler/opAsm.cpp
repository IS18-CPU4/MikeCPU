#include <iostream>
#include <string>
#include <stdint.h>
#include <vector>
#include <sstream>
#include <unordered_map>
#include <regex>
#include "opAsm.h"

using namespace std;

uint32_t op;
extern uint32_t PC;

unordered_map<string, uint32_t> labelMap;

vector<string> StringSplit(const string str, char sep) {
	vector<string> v;
	stringstream ss(str);
	string buffer;
	while(getline(ss, buffer, sep)) {
		v.push_back(buffer);
	}
	return v;
}

uint32_t get_rD(const string str) {
	vector<string> vtmp = StringSplit(str, 'r');
	try{
		int r = stoi(vtmp[1]);
		return r << 21;
	}catch (const invalid_argument &e) {
		cerr << "error in rD...invalid_argument" << endl;
		return 0xFFFFFFFF;
	}
}	
uint32_t get_rA(const string str) {
	vector<string> vtmp = StringSplit(str, 'r');
	try{
		int r = stoi(vtmp[1]);
		return r << 16;
	}catch (const invalid_argument &e) {
		cerr << "error in rA...invalid_argument" << endl;
		return 0xFFFFFFFF;
	}
}
uint32_t get_rB(const string str) {
	vector<string> vtmp = StringSplit(str, 'r');
	try{
		int r = stoi(vtmp[1]);
		return r << 11;
	} catch (const invalid_argument &e) {
		cerr << "error in rB...invalid_argument" << endl;
		return 0xFFFFFFFF;
	}
}
uint32_t get_simm16(const string str) {
	//int r = stoi(str);
	//cout << "getsimm16" << endl;

	uint32_t simm16;
	regex re(R"(ha\(.*\))");
	regex re2(R"(lo\(.*\))");
	if (regex_match(str, re)) {
		vector<string> vtmp = StringSplit(str, '(');
		vtmp[1].erase(vtmp[1].size() -1);
		cout <<  "ha of " << vtmp[1] << endl;
		try{
			simm16 = stoi(vtmp[1], nullptr, 0);
			return ((simm16 >> 16) & 0x0000FFFF);
		} catch (const invalid_argument& e) {
			try{
				simm16 = labelMap.at(vtmp[1]);
				cout << "ha(label)" << hex << simm16 << dec << endl;
				return ((simm16 >> 16) & 0x0000FFFF);
			} catch (const out_of_range&) {
				cerr << "error in simm16...invalid_argument or undefined label" << endl;
				return 0xFFFFFFFF;
			}
		}
	}else if (regex_match(str, re2)) {
		vector<string> vtmp = StringSplit(str, '(');
		vtmp[1].erase(vtmp[1].size()-1);
		cout << "lo of " <<  vtmp[1] << endl;
		try{
			simm16 = stoi(vtmp[1], nullptr, 0);
			return (simm16 & 0x0000FFFF);
		} catch (const invalid_argument& e) {
			try{
				simm16 = labelMap.at(vtmp[1]);
				cout << "lo(label)" << hex << simm16 << dec << endl;
				return (simm16 & 0x0000FFFF);
			} catch (const out_of_range&) {
				cerr << "error in simm16...invalid_argument or undefined label" << endl;
				return 0xFFFFFFFF;
			}
		}
	}else {

	//	cout << "simm16 normal" << endl;
		try{
			simm16 = stoi(str, nullptr, 0);
			return (simm16 & 0x0000FFFF);
		} catch (const invalid_argument& e) {
			try {
				simm16 = labelMap.at(str);
				cout << "label address: " << hex << simm16 << dec << endl;
				return (simm16 & 0x0000FFFF);
			} catch (const out_of_range&) {
				cerr << "error in simm16...invalid_argument or undefined label" << endl;
				return 0xFFFFFFFF;
			}
		}
	}
}
uint32_t get_imm5(const string str) {
	try{
		int r = stoi(str);
		return r << 11;
	}catch (const invalid_argument &e) {
		cerr << "error in imm5...invalid_argument" << endl;
		return 0xFFFFFFFF;
	}
}
uint32_t get_simm26(const string str) {
	//labalでアドレスが指定されているならmapからlabelを探す
	uint32_t addr;
	try{
		addr = stoi(str, nullptr, 0);
		cout << "immdiate address" << endl;
		uint32_t simm26 =  addr - PC;
		cout << "simm26: "<< hex << simm26 << dec << endl;
		return ((simm26 >> 2) & 0x03FFFFFF);
	} catch (const invalid_argument& e) {
		try {
			addr = labelMap.at(str);
			cout << "label address: " << hex << addr << dec << endl;
			uint32_t simm26 =  addr - PC;
			cout << "simm26: "<< hex << simm26 << dec << endl;
			return ((simm26 >> 2) & 0x03FFFFFF);
		} catch (const out_of_range&) {
			cerr << "error in simm 26...invalid_argument or undefined label" << endl;
			return 0xFFFFFFFF;
		}
	}
}


//integer
uint32_t op_li(const vector<string>& vitem) {
	op = 0;
	return (op | get_rD(vitem[1]) | get_simm16(vitem[2]));
}
uint32_t op_mr(const vector<string>& vitem) {
	op = (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}
uint32_t op_addi(const vector<string>& vitem){
	op = (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}
uint32_t op_add(const vector<string>& vitem){
	op = (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_sub(const vector<string>& vitem){
	op = (1 << 28);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}

uint32_t op_slwi(const vector<string>& vitem){
	op = (1 << 28) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_imm5(vitem[3]));
}
uint32_t op_srwi(const vector<string>& vitem){
	op = (1 << 28) | (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_imm5(vitem[3]));
}


//float
uint32_t op_fadd(const vector<string>& vitem){
	op = (1 << 28) | (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_fsub(const vector<string>& vitem){
	op = (1 << 29);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_fdiv(const vector<string>& vitem){
	op = (1 << 29) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_fmul(const vector<string>& vitem){
	op = (1 << 29) | (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_fsqrt(const vector<string>& vitem){
	op = (1 << 29) | (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}
uint32_t op_fabs(const vector<string>& vitem){
	op = (1 << 29) | (1 << 28);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}
uint32_t op_fmr(const vector<string>& vitem){
	op = (1 << 29) | (1 << 28) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}


//条件分岐
uint32_t op_b(const vector<string>& vitem) {
	op = (1 << 29)| (1 << 28) | (1 << 27);
	return (op | get_simm26(vitem[1]));
}
uint32_t op_beq(const vector<string>& vitem){
	op = (1 << 29)| (1 << 28) | (1 << 27) | (1 << 26);
	return (op | get_simm26(vitem[1]));
}
uint32_t op_bne(const vector<string>& vitem){
	op = (1 << 30);
	return (op | get_simm26(vitem[1]));
}
uint32_t op_blt(const vector<string>& vitem){
	op = (1 << 30)| (1 << 26);
	return (op | get_simm26(vitem[1]));
}
uint32_t op_bl(const vector<string>& vitem){
	op = (1 << 30)| (1 << 27);
	return (op | get_simm26(vitem[1]));
}
uint32_t op_blr(const vector<string>& vitem){
	op = (1 << 30) | (1 << 27) | (1 << 26);
	return op;
}
uint32_t op_mflr(const vector<string>& vitem){
	op = (1 << 30) | (1 << 28);
	return (op | get_rD(vitem[1]));
}
uint32_t op_mtlr(const vector<string>& vitem){
	op = (1 << 30) | (1 << 28) | (1 << 26);
	return (op | get_rD(vitem[1]));
}


//compare
uint32_t op_cmpwi(const vector<string>& vitem){
	op = (1 << 30) | (1 << 28) | (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}
uint32_t op_cmpw(const vector<string>& vitem){
	op = (1 << 30) | (1 << 28) | (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_fcmp(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}


//load and store
uint32_t op_ld(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}
uint32_t op_st(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}
uint32_t op_fld(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}
uint32_t op_fst(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 28);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_simm16(vitem[3]));
}

//addded


uint32_t op_slw(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 28) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_srw(const vector<string>& vitem){
	op = (1 << 30) | (1 << 29) | (1 << 28) | (1 << 27);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]) | get_rB(vitem[3]));
}
uint32_t op_bc(const vector<string>& vitem){
	uint32_t simm16 = get_simm16(vitem[2]);
	//simm16は絶対アドレスになるので0以上。
	uint32_t addr = ((simm16 - PC) >> 2)& 0x0000FFFF;
	op = (1 << 30) | (1 << 29) | (1 << 28) | (1 << 27) | (1 << 26);
	return (op | get_rA(vitem[1]) | addr);
}
uint32_t op_itof(const vector<string>& vitem){
	op = (1 << 31);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}
uint32_t op_ftoi(const vector<string>& vitem){
	op = (1 << 31) | (1 << 26);
	return (op | get_rD(vitem[1]) | get_rA(vitem[2]));
}
uint32_t op_out(const vector<string>& vitem) {
	op = (1 << 31) | (1 << 30) | (1 << 29) | (1 << 28) | (1 << 27) | (1 << 26);
	return (op |get_rD(vitem[1]));
}

uint32_t op_ba(const vector<string>& vitem) {
	op = (1 << 31) | (1 << 27);
	return (op |get_rD(vitem[1]));
}
uint32_t op_bal(const vector<string>& vitem) {
	op = (1 << 31) | (1 << 27) | (1 << 26);
	return (op | get_rD(vitem[1]));
}

uint32_t set_txt(const vector<string>& vitem) {
	return 0;
}
uint32_t set_align(const vector<string>& vitem) {
	return 0;
}
uint32_t set_globl(const vector<string>& vitem) {
	return 0;
}
uint32_t set_label(const vector<string>& vitem) {
	/*vector<string> vtmp = StringSplit(vitem[0], ':');
	labelMap[vtmp[0]] = PC;
	*/cout << "PC: "<<  hex << PC << dec << endl;
	return 0;
}
