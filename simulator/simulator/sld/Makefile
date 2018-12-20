CC = g++
CFLAGS = -std=c++11 -Wall

ALL: sld_converter.o
	$(CC) $(CFLAGS) -o sld_converter sld_converter.o

sld_converter.o: sld_converter.cpp
	$(CC) $(CFLAGS) -o sld_converter.o -c sld_converter.cpp

clean:
	rm -rf *.o *.txt *.bin sld_converter
