`timescale 1ns / 100ps
`default_nettype none

module test_itof();
   wire [31:0] x1,x2,y;
   wire        ovf;
   logic [31:0] x1i,x2i;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;
   bit 	      fovf;
   bit 	      checkovf;

   assign x1 = x1i;
   
   itof u1(x1,y);

   initial begin
      // $dumpfile("test_fmul.vcd");
      // $dumpvars(0);

      for (i=-4294967295; i<4294967295; i++) begin // 全部検査
                        x1i = i[31:0];

                        fy = shortreal'($itor(i));
                        fybit = $shortrealtobits(fy);

                        #1;

                        if (fybit !== y) begin
                           $display("x = %b", x1);
                           $display("%e %b\n", fy, fybit);
                           $display("%e %b\n", $bitstoshortreal(y), y);
                        end
      end
      $finish;
   end
endmodule

`default_nettype wire
