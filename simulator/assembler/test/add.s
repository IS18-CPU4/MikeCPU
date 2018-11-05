calc:
	li r1, 4
	addi r2, r1, 16
	add r5, r2, r1
end:
	li r6, ha(0x4321478)
	li r7, lo(end)
	mr r1, r5

