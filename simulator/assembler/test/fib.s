#pls set r1<- argument
fib:
	cmpwi cr0, r1, 0
	blt mzero
	beq mzero
	li r2, 1
	li r5, 0
	b calc
calc:
	cmpwi cr0, r1, 1
	beq end
	mr r6, r2
	add r2, r2, r5
	mr r5, r6
	addi r1, r1, -1
	b calc
mzero:
	li r1, 0
	b return
end:
	mr r1, r2
	b return
return:
