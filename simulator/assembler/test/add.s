calc:
	li r1, 4
	addi r2, r1, 16
	add r5, r2, r1
_min_caml_start:
	li r5, 5
	addi r6, r5, 30
	add r7, r6, r5
end:
	li r8, ha(0x4321478)
	li r9, lo(end)
	mr r1, r5

