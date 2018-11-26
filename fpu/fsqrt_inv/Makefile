FILE = fsqrt_inv
SRCS =

all: run

run:
	xvlog --sv test_$(FILE).sv $(FILE).vi $(SRCS)
	xelab -debug typical test_$(FILE) -s test_$(FILE).sim
	xsim --runall test_$(FILE).sim

clean:
	rm -rf xsim.dir *.wdb *.jou *.log *.pb

.PHONY: all clean
