calc:
	li r1, 0xc2b6
	li r2, 0x999a
	slwi r1, r1, 16
	add r1, r1, r2
	st r1, r3, 0
	fld fr0, r3, 0
