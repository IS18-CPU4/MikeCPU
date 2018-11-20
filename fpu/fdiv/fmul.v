`default_nettype none

module fmul
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

   // split sequence to each subsequence
   wire s1, s2;
   wire [7:0] e1, e2;
   wire [22:0] m1, m2;
   assign {s1, e1, m1} = x1;
   assign {s2, e2, m2} = x2;

   // calc s for y
   wire s;
   assign s = s1 ^ s2;

   // calc m
   wire [47:0] tmp_m;
   // 1 is appended to m1 and m2 before multiplication
   assign tmp_m = {1'b1, m1} * {1'b1, m2};
   wire [22:0] m;
   assign m = (tmp_m[47] == 1'b0) ? tmp_m[45:23] : tmp_m[46:24];

   // calc e
   wire [8:0] tmp_e;
   assign tmp_e = (tmp_m[47] == 1'b0) ? {1'b0, e1} + {1'b0, e2} : {1'b0, e1} + {1'b0, e2} + 9'd1;
   wire [8:0] tmp_tmp_e;
   wire [7:0] e;
   assign tmp_tmp_e = tmp_e - 9'd127;
   assign e = tmp_tmp_e[7:0];

   // determine whether overflow or underflow
   wire unf;
   assign unf = (tmp_e <= 9'd127) || (e1 == 8'd0 || e2 == 8'd0); 
   assign ovf = (tmp_e >= 9'd382);

   assign y = (unf) ? 32'd0 :
              (ovf) ? {s, 31'b1111111100000000000000000000000} : {s, e, m};

endmodule

`default_nettype wire
