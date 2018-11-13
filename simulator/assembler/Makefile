CC = g++
CFLAGS = -std=c++11 -Wall

ALL: asm.o encode.o opAsm.o
	$(CC) $(CFLAGS) -o asm asm.o encode.o opAsm.o

asm.o: asm.cpp
	$(CC) $(CFLAGS) -o asm.o -c asm.cpp

encode.o: encode.cpp encode.h
	$(CC) $(CFLAGS) -o encode.o -c encode.cpp

opAsm.o: opAsm.cpp opAsm.h
	$(CC) $(CFLAGS) -o opAsm.o -c opAsm.cpp


clean:
	rm -rf *.o out.bin asm

