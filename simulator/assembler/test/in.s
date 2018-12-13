start:
	in r1
	in r2
	in r5
	in r6
	slwi r1, r1, 24
	slwi r2, r2, 16
	slwi r5, r5, 8
	add r7, r1, r2
	add r7, r7, r5
	add r7, r7, r6
	in r1
	in r2
	in r5
	in r6
	slwi r1, r1, 24
	slwi r2, r2, 16
	slwi r5, r5, 8
	add r8, r1, r2
	add r8, r8, r5
	add r8, r8, r6
	in r1
	in r2
	in r5
	in r6
	slwi r1, r1, 24
	slwi r2, r2, 16
	slwi r5, r5, 8
	add r9, r1, r2
	add r9, r9, r5
	add r9, r9, r6
	st r9, r3, 0
	fld fr0, r3, 0
