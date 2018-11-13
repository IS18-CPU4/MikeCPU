out:
	out r1
	out r2
	out r5
	out r6
	b end
_min_caml_start:
	li r1, 0x30
	li r2, 0x61
	addi r5, r2, 1
	addi r6, r2, 2
	b out
end:
	li r1, 0
