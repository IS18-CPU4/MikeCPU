calc:
	li r3, 4
	addi r4, r3, 16
	add r5, r4, r3
end:
	li r6, ha(0x4321478)
	li r7, lo(end)
	mr r3, r5

