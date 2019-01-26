CC = g++
CFLAGS = -std=c++11 -O2 -Wall

ALL:test_fadd test_fsub test_fmul test_fdiv test_finv test_fsqrt test_ftoi test_itof

test_fadd: test_fadd.o float/fadd.o
	$(CC) $(CFLAGS) -o test_fadd test_fadd.o float/fadd.o

test_fadd.o: test_fadd.cpp
	$(CC) $(CFLAGS) -o test_fadd.o -c test_fadd.cpp

float/fadd.o: float/fadd.cpp float/fadd.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/fadd.o -c float/fadd.cpp


test_fsub: test_fsub.o float/fsub.o float/fadd.o
	$(CC) $(CFLAGS) -o test_fsub test_fsub.o float/fsub.o float/fadd.o

test_fsub.o: test_fsub.cpp
	$(CC) $(CFLAGS) -o test_fsub.o -c test_fsub.cpp

float/fsub.o: float/fsub.cpp float/fsub.h float/fcalc.h float/fadd.h
	$(CC) $(CFLAGS) -o float/fsub.o -c float/fsub.cpp


test_fmul: test_fmul.o float/fmul.o
	$(CC) $(CFLAGS) -o test_fmul test_fmul.o float/fmul.o

test_fmul.o: test_fmul.cpp
	$(CC) $(CFLAGS) -o test_fmul.o -c test_fmul.cpp

float/fmul.o: float/fmul.cpp float/fmul.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/fmul.o -c float/fmul.cpp


test_fdiv: test_fdiv.o float/fdiv.o float/fmul.o float/finv.o
	$(CC) $(CFLAGS) -o test_fdiv test_fdiv.o float/fdiv.o float/fmul.o float/finv.o

test_fdiv.o: test_fdiv.cpp
	$(CC) $(CFLAGS) -o test_fdiv.o -c test_fdiv.cpp

float/fdiv.o: float/fdiv.cpp float/fdiv.h float/fcalc.h float/fmul.h float/finv.h
	$(CC) $(CFLAGS) -o float/fdiv.o -c float/fdiv.cpp


test_finv: test_finv.o float/finv.o
	$(CC) $(CFLAGS) -o test_finv test_finv.o float/finv.o

test_finv.o: test_finv.cpp
	$(CC) $(CFLAGS) -o test_finv.o -c test_finv.cpp

float/finv.o: float/finv.cpp float/finv.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/finv.o -c float/finv.cpp


test_fsqrt: test_fsqrt.o float/fsqrt.o float/fmul.o
	$(CC) $(CFLAGS) -o test_fsqrt test_fsqrt.o float/fsqrt.o float/fmul.o

test_fsqrt.o: test_fsqrt.cpp
	$(CC) $(CFLAGS) -o test_fsqrt.o -c test_fsqrt.cpp

float/fsqrt.o: float/fsqrt.cpp float/fsqrt.h float/fcalc.h float/fmul.h
	$(CC) $(CFLAGS) -o float/fsqrt.o -c float/fsqrt.cpp


test_ftoi: test_ftoi.o float/ftoi.o
	$(CC) $(CFLAGS) -o test_ftoi test_ftoi.o float/ftoi.o

test_ftoi.o: test_ftoi.cpp
	$(CC) $(CFLAGS) -o test_ftoi.o -c test_ftoi.cpp

float/ftoi.o: float/ftoi.cpp float/ftoi.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/ftoi.o -c float/ftoi.cpp

test_itof: test_itof.o float/itof.o
	$(CC) $(CFLAGS) -o test_itof test_itof.o float/itof.o

test_itof.o: test_itof.cpp
	$(CC) $(CFLAGS) -o test_itof.o -c test_itof.cpp

float/itof.o: float/itof.cpp float/itof.h float/fcalc.h
	$(CC) $(CFLAGS) -o float/itof.o -c float/itof.cpp


clean:
	rm -rf *.o float/*.o test_fadd test_fsub test_fmul test_fdiv test_finv test_fsqrt test_ftoi test_itof
