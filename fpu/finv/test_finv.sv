`timescale 1ns / 100ps
`default_nettype none

module test_finv();
   wire [31:0] x,y;
   wire        ovf;
   logic [31:0] xi;
   shortreal    fx,fy;
   int          i,k,it;
   bit [22:0]   m;
   bit [7:0]    e;
   bit [22:0]    dum;
   logic [31:0] fybit;
   int          s;
   logic [23:0] dy;
   bit [22:0] tm;
   bit 	      fovf;
   bit 	      checkovf;

   assign x = xi;
   
   finv u1(x,y,ovf);

   initial begin
      // $dumpfile("test_finv.vcd");
      // $dumpvars(0);

      for (i=0; i<8388608; i++) begin // 0 ~ 2^23-1
        #1;
        m = i[22:0];
        {s, e, dum} = $urandom();
        xi = {s,e,m};

        fx = $bitstoshortreal(xi);
        fy = 1 / fx; // inverse
        fybit = $shortrealtobits(fy);

        checkovf = e < 255;
        if ( checkovf && fybit[30:23] == 255 ) begin
           fovf = 1;
        end else begin
           fovf = 0;
        end
        
        #1;

        if (fybit[30:23] === 0 || (fybit[30:23] === 23'd1 && fybit[22:0] === 23'd0)) begin
           if (!(y === 0 || y[30:0] === fybit[30:0])) begin
              $display("x = %b", x);
              $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
           end
        end else begin
           if (!(y+32'd1 === fybit || y === fybit || y-32'd1 === fybit) || ovf !== fovf) begin
              $display("x = %b", x);
              $display("%e %b %b", fy, $shortrealtobits(fy), fovf);
              $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
           end
        end
      end
      $finish;
   end
endmodule

`default_nettype wire
