#ifndef OP_H_
#define OP_H_

int do_op();
inline uint32_t get_opname(const uint32_t ui) {
	uint32_t opname = ui>>26;
	return opname;
}


#endif //OP_H_
