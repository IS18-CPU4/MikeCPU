#pls set r3 <- argument
fib:
	cmpwi cr0, r3, 0
	blt mzero
	beq mzero
	li r4, 1
	li r5, 0
	b calc
calc:
	cmpwi cr0, r3, 1
	beq end
	mr r6, r4
	add r4, r4, r5
	mr r5, r6
	addi r3, r3, -1
	b calc
mzero:
	li r3, 0
	b return
end:
	mr r3, r4
	b return
return:
