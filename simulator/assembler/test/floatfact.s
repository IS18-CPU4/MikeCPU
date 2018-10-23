init:
	fmr fr4, fr3
	fmr fr5, fr0
calc:
	fcmp fr3, fr1
	beq end
	fst fr3, r1, 4
	addi r1, r1, -4
	fsub fr3, fr3, fr1
	b calc
end:
	fadd fr5, fr5, fr3
loop:
	addi r1, r1, 4
	fld fr3, r1, 4
	fadd fr5, fr5, fr3
	fcmp fr3, fr4
	blt loop
	fmr fr1, fr5

