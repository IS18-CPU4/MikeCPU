#compare minus & minus
calc:
	li r1, -1
	li r2, 0
	itof fr1, r1
	itof fr2, r2
	cmpw cr0, r1, r2
	bc cr0, lessthan
	li r1, 1
	b end
lessthan:
	cmpwi cr0, r1, 0
	bc cr0, lessthan2
	li r1, 2
	b end
lessthan2:
	fcmp cr0, fr1, fr2
	bc cr0, ok
	li r1, 3
	b end
ok:
	li r1, 0
end:
