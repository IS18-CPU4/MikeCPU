start:
	li r1, 3
	li r2, 6
	itof fr1, r1
	itof fr2, r2
	fdiv fr0, fr1, fr2
	ftoi r5, fr0
