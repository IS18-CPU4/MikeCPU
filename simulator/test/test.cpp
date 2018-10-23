#include <iostream>
#include <stdint.h>
#include <stdio.h>
#include <vector>
#include <math.h>
#include <sstream>
#include <string>
#include <fstream>
using namespace std;

vector<string> StringSplit(const string str, char sep) {
	vector<string> v;
	stringstream ss(str);
	string buffer;
	while(getline(ss, buffer, sep)) {
		v.push_back(buffer);
	}
	return v;
}
string trim(const string& str, const char* trimCharacterList = "\t\v\r\n") {
	string result;
	string::size_type left = str.find_first_not_of(trimCharacterList);

	if (left != string::npos) {
		string::size_type right = str.find_last_not_of(trimCharacterList);
		result = str.substr(left, right-left+1);
	}
	return result;
}

int main(int argc, char** argv) {
	/*uint32_t a = 0x0000000F;
	cout << (int)a << endl;
	uint32_t b = 0x0000000F;
	uint32_t c = a + b;
	cout << c << endl;
	printf("%x\n", c);*/

	/*uint32_t c = 0x0000000E;
	int32_t d = 0xFFFFFFFF;
	uint32_t e = c + d;
	cout << e << endl;
	printf("%x\n", e);*/
	//printf("%x\n", (uint32_t)e);

	/*float e = 2.7;
	//float f = 3.4;
	printf("%f\n", e);
	//printf("%f\n", f);
	float g = sqrt(e);
	cout << g << endl;
	printf("%f\n", g);*/

	/*vector<string> vkey = StringSplit("li rD, value", ' ');
	cout << vkey[0] << endl;
	cout << vkey[1] << endl;
	cout << vkey[2] << endl*/;
	/*string str = "	addi rD, rA,5		";
	str = trim(str);
	vector<string> vitem;
	vector<string> vitem1 = StringSplit(str, ' ');
	//,カンマを削除
	vector<string>::iterator itr; 
	for (itr = vitem1.begin(); itr != vitem1.end(); itr++) {
		vector<string> vitem2 = StringSplit(*itr, ',');
		vector<string>::iterator itr2;
		for (itr2 = vitem2.begin(); itr2 != vitem2.end(); itr2++) {
			vitem.push_back(*itr2);
		}
	}
	vector<string>::iterator itrout;
	for (itrout = vitem.begin(); itrout != vitem.end(); itrout++) {
		cout << *itrout << endl;
	}*/

	if (argc < 2) {
		cerr << "too few arguments!" << endl;
		return 1;
	}
	cout << "open inputfile..." << endl;
	ifstream filein(argv[1]);
	string line;
	while (getline(filein,line)) {
		cout << line << endl;
		if (line == "") {
			cout << "null line" << endl;
		}
	}
}
