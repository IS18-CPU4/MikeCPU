#ifndef FCALC_H
#define FCALC_H

static inline uint32_t getBit32(uint32_t x, int max, int min) {
	uint32_t tmp = x << (31 - max);
	tmp = tmp >> (31-max+min);
	return tmp;
}
static inline uint64_t getBit64(uint64_t x, int max, int min) {
	uint64_t tmp = x << (63 - max);
	tmp = tmp >> (63-max+min);
	return tmp;
}

#endif //FCALC_H
