`default_nettype none

module finv
   ( input wire [31:0] x,
     output wire [31:0] y,
     output wire ovf);

   /* TODO: assumptions
    * - inputs and output are not unnormal numbers or NaN or +-inf 
    * - if e is 0, the number is interpreted as +0
    * - overflow and underflow are treated as the same for ovf wire
    * - when underflow, y will be 0
    */

   // split sequence to each subsequence
   wire xs;
   wire [7:0] xe;
   wire [22:0] xm;
   assign {xs, xe, xm} = x;

   // calc s
   wire s;
   assign s = xs;

   // calc e
   wire [7:0] e;
   assign e = (xm == 23'd0) ? 8'd254 - xe : 8'd253 - xe; 

endmodule

`default_nettype wire
