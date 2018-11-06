start:
	li r1, 3
	cmpwi cr0, r1, 4
	bc cr0, lessthan
	li r2, 3
	b end
equal:
	cmpwi cr2, r1, 2
	bc cr9, lo(morethan)
	li r2, 4
	b end
lessthan:
	cmpwi cr3, r1, 3
	bc cr14, equal
	li r2, 2
	b end
morethan:
	li r2, 0
	b end
end:
	mr r1, r2
# return number =  0:success 3:neg? 4:pos? 2:neg?
