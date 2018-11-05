CC = g++
CFLAGS = -std=c++11 -Wall

ALL: sim.o op.o instruction.o
	$(CC) $(CFLAGS) -o sim sim.o op.o instruction.o

sim.o: sim.cpp
	$(CC) $(CFLAGS) -o sim.o -c sim.cpp

op.o: op.cpp op.h
	$(CC) $(CFLAGS) -o op.o -c op.cpp

instruction.o: instruction.cpp instruction.h
	$(CC) $(CFLAGS) -o instruction.o -c instruction.cpp


clean:
	rm -rf *.o sim

