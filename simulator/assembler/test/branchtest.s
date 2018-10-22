branch0:
	li r3, 3
	b branch2
branch1:
	li r5, 4
	cmpw r4, r5
	beq branch3
branch2:
	li r4, 4
	cmpw r3, r4
	blt branch1
branch3:
	fcmp fr3, fr4
	bne branch5
branch4:
	blr
branch5:
	bl branch4

