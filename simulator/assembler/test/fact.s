#sum of 1 to argument
#pls set r1 <- argument
init:
	mr r2, r1
	mr r5, r0
calc:
	cmpwi cr0, r1, 1
	beq end
	st r1, r3, 4
	addi r3, r3, -4
	addi r1, r1, -1
	b calc
end:
	add r5, r5, r1
loop:
	addi r3, r3, 4
	ld r1, r3, 4
	add r5, r5, r1
	cmpw cr0, r1, r2
	blt loop
	mr r1, r5

