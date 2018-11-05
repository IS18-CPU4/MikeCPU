start:
	li r1, 3
	cmpwi cr0, r1, 3
	bc cr2, equal
	li r2, 3
	b end
equal:
	cmpwi cr2, r1, 4
	bc cr8, lessthan
	li r2, 4
	b end
lessthan:
	cmpwi cr3, r1, 2
	bc cr13, morethan
	li r2, 2
	b end
morethan:
	li r2, 0
	b end
end:
	mr r2, r4
# return number =  0:success 3:eq? 4:neg? 2:pos?
