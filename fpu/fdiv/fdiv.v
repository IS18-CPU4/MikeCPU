`default_nettype none

module fdiv
   ( input wire [31:0] x1,
     input wire [31:0] x2,
     output wire [31:0] y,
     output wire ovf);

   /* assumptions
    * - inputs and output are not unnormal numbers or NaN or +-inf 
    * - if e is 0, the number is interpreted as +0
    * - overflow and underflow are treated as the same for ovf wire
    * - when underflow, y will be 0
    */
   
   wire [31:0] x2_inv;
   wire inv_ovf;
   finv u1(x2, x2_inv, inv_ovf);

   fmul u2(x1, x2_inv, y, ovf);
endmodule

`default_nettype wire
