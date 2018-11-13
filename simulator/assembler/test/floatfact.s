#pls set fr0 <- argument
#				 fr1 <- 1
#				fr5 <- 0
init:
	fmr fr4, fr0
calc:
	fcmp cr0, fr0, fr1
	beq end
	fst fr0, r3, 4
	addi r3, r3, -4
	fsub fr0, fr0, fr1
	b calc
end:
	fadd fr5, fr5, fr0
loop:
	addi r3, r3, 4
	fld fr0, r3, 4
	fadd fr5, fr5, fr0
	fcmp cr0, fr0, fr4
	blt loop
	fmr fr0, fr5

