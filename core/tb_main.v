`timescale 1ns/1ps

module tb_main;
    reg CLK, RST;
    wire [0:31] out_wire;

    parameter CYC = 100;
    always #(CYC/2) CLK = ~CLK;

    controller cont(
        out_wire,
        CLK,
        RST
    );

    initial begin
      $dumpfile("tb_main.vcd");
      $dumpvars(0, tb_main);

      #(0) CLK = 0; RST = 1;
      #(CYC*10) RST = 0;
      #(CYC*1024) $finish;
    end
endmodule