start:
	li r1, lo(0x18)
	srwi r1, r1, 2
	bal r1
	li r2, lo(branch2)
	srwi r2, r2, 2
	ba r2
branch:
	li r5, 1
	addi r6, r5, 1
	blr
branch2:
	li r7, 3
	addi r8, r7, 1
