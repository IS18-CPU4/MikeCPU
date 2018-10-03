CC="C:\iverilog\bin\iverilog.exe"
SIM="C:\iverilog\bin\vvp.exe"
WAVE="C:\iverilog\gtkwave\bin\gtkwave.exe"

all: main

main: main.v tb_main.v
	$(CC) -o tb_main.o $^ && $(SIM) tb_main.o

wave:
	$(WAVE) tb_main.vcd
