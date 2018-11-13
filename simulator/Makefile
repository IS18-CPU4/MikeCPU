all:make_asm make_sim

make_asm:
	(cd assembler; make)

make_sim:
	(cd simulator; make)

clean:asm_clean sim_clean

asm_clean:
	(cd assembler; make clean)

sim_clean:
	(cd simulator; make clean)
