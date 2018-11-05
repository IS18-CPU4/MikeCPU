#??????
start:
	li r1, 3
	cmpwi cr0, r1, 0
	b calc
calc:
	cmpwi cr0, r1, 1
	beq end
	addi r1, r1, -1
	b calc
end:
