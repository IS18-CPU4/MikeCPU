`default_nettype none

module ftoi
   ( input wire [31:0] x,
     output wire [31:0] y,
     output wire ovf);

   // split sequence to each subsequence
   wire s;
   wire [7:0] e;
   wire [22:0] m;
   assign {s, e, m} = x;

   wire [23:0] m1;
   assign m1 = {1'b1, m};

   wire ov;
   assign ov = m1[(8'd149 - e)];

   wire [30:0] i;
   assign i = (e == 8'd126) ? 31'd1 :
              (e <= 8'd125) ? 31'd0 :
              (e >= 8'd150) ? m1 << (e - 8'd127) : (m1 << (e - 8'd127))  + {30'd0, ov};

   assign ovf = (e >= 8'd158);

   assign y = (s == 0) ? {s, i} : {1'b1, ~i} + 32'd1;

endmodule

`default_nettype wire
