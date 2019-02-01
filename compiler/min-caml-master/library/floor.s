min_caml_floor:
	fld	fr2, r0, 0
	fsub	fr1, fr1, fr2
	mflr	r31
	st	r31, r3, 4
	addi	r3, r3, 8
	bl	min_caml_int_of_float
	addi	r3, r3, -8
	ld	r31, r3, 4
	mtlr	r31
	b	min_caml_float_of_int
