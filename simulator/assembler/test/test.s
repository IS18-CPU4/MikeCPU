#??????
start:
	li r3, 3
	cmpwi cr0, r3, 0
	b calc
calc:
	cmpwi cr0, r3, 1
	beq end
	addi r3, r3, -1
	b calc
end:
