`default_nettype none

module f_mul
   ( input wire [31:0] x1,
     input wire [31:0] x2,
     output reg [31:0] y,
     output reg ovf,
     input wire clk,
     input wire rstn);

  wire s1, s2;
  wire [7:0] e1, e2;
  wire [22:0] m1, m2;

  assign {s1, e1, m1} = x1;
  assign {s2, e2, m2} = x2;

  wire s;
  wire [7:0] e;
  wire [8:0] tmp_e;
  wire [45:0] tmp_m;

  assign s = s1 ^ s2; // XOR
  assign tmp_e = e1 + e2 + 9'd127;
  assign tmp_m = m1 * m2;

  always @(posedge clk) begin
     if (~rstn) begin
       y <= 0;
       ovf <= 0;
     end else begin
     end
   end
endmodule

`default_nettype wire
