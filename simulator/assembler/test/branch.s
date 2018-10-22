init:
	li r3, 4
	li r4, 1
calc:
	addi r4, r4, 1
compare:
	cmpw r4, r3
	blt calc
