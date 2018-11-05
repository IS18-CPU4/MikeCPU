#pls set r3 <- argument
init:
	mr r4, r3
	mr r5, r0
calc:
	cmpwi r3, 1
	beq end
	st r3, r1, 4
	addi r1, r1, -4
	addi r3, r3, -1
	b calc
end:
	add r5, r5, r3
loop:
	addi r1, r1, 4
	ld r3, r1, 4
	add r5, r5, r3
	cmpw r3, r4
	blt loop
	mr r3, r5

