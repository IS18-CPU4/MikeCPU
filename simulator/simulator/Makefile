CC = g++
CFLAGS = -std=c++11 -O2 -Wall

ALL: sim.o revAsm.o op.o instruction.o float/fadd.o float/fsub.o float/fmul.o float/finv.o float/fdiv.o float/ftoi.o float/itof.o
	$(CC) $(CFLAGS) -o sim sim.o revAsm.o op.o instruction.o float/fadd.o float/fsub.o float/fmul.o float/finv.o float/fdiv.o float/ftoi.o float/itof.o

sim.o: sim.cpp
	$(CC) $(CFLAGS) -o sim.o -c sim.cpp

revAsm.o: revAsm.cpp revAsm.h
	$(CC) $(CFLAGS) -o revAsm.o -c revAsm.cpp

op.o: op.cpp op.h
	$(CC) $(CFLAGS) -o op.o -c op.cpp

instruction.o: instruction.cpp instruction.h
	$(CC) $(CFLAGS) -o instruction.o -c instruction.cpp

float/fadd.o: float/fadd.cpp float/fadd.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/fadd.o -c float/fadd.cpp

float/fsub.o: float/fsub.cpp float/fsub.h float/fcalc.h float/fadd.h
	$(CC) $(CFLAGS) -o float/fsub.o -c float/fsub.cpp

float/fmul.o: float/fmul.cpp float/fmul.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/fmul.o -c float/fmul.cpp
	
float/finv.o: float/finv.cpp float/finv.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/finv.o -c float/finv.cpp

float/fdiv.o: float/fdiv.cpp float/fdiv.h float/fcalc.h float/fmul.h float/finv.h
	$(CC) $(CFLAGS) -o float/fdiv.o -c float/fdiv.cpp

float/ftoi.o: float/ftoi.cpp float/ftoi.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/ftoi.o -c float/ftoi.cpp

float/itof.o: float/itof.cpp float/itof.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/itof.o -c float/itof.cpp


clean:
	rm -rf *.o float/*.o out.bin a.out sim
