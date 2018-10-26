start:
	li r3, 3
	cmpwi r3, 3
	bc cr2, equal
	li r4, 3
	b end
equal:
	cmpwi r3, 4
	bc cr0, lessthan
	li r4, 4
	b end
lessthan:
	cmpwi r3, 2
	bc cr1, morethan
	li r4, 2
	b end
morethan:
	li r4, 0
	b end
end:
	mr r3, r4
# 0:success 3:eq? 4:neg? 2:pos?
