`default_nettype none

module itof
   ( input wire [31:0] x,
     output wire [31:0] y);

   // split sequence to each subsequence
   wire s;
   wire [30:0] i;
   assign {s, i} = x;
   wire [30:0] i_abs;
   assign i_abs = (s == 1'b0) ? i : ~(i - 31'b1);
   wire [4:0] l;
   function [4:0] SE (
     input [30:0] M
   );
     begin
     casex(M)
       31'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd0;
       31'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd1;
       31'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd2;
       31'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd3;
       31'b00001xxxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd4;
       31'b000001xxxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd5;
       31'b0000001xxxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd6;
       31'b00000001xxxxxxxxxxxxxxxxxxxxxxx: SE = 5'd7;
       31'b000000001xxxxxxxxxxxxxxxxxxxxxx: SE = 5'd8;
       31'b0000000001xxxxxxxxxxxxxxxxxxxxx: SE = 5'd9;
       31'b00000000001xxxxxxxxxxxxxxxxxxxx: SE = 5'd10;
       31'b000000000001xxxxxxxxxxxxxxxxxxx: SE = 5'd11;
       31'b0000000000001xxxxxxxxxxxxxxxxxx: SE = 5'd12;
       31'b00000000000001xxxxxxxxxxxxxxxxx: SE = 5'd13;
       31'b000000000000001xxxxxxxxxxxxxxxx: SE = 5'd14;
       31'b0000000000000001xxxxxxxxxxxxxxx: SE = 5'd15;
       31'b00000000000000001xxxxxxxxxxxxxx: SE = 5'd16;
       31'b000000000000000001xxxxxxxxxxxxx: SE = 5'd17;
       31'b0000000000000000001xxxxxxxxxxxx: SE = 5'd18;
       31'b00000000000000000001xxxxxxxxxxx: SE = 5'd19;
       31'b000000000000000000001xxxxxxxxxx: SE = 5'd20;
       31'b0000000000000000000001xxxxxxxxx: SE = 5'd21;
       31'b00000000000000000000001xxxxxxxx: SE = 5'd22;
       31'b000000000000000000000001xxxxxxx: SE = 5'd23;
       31'b0000000000000000000000001xxxxxx: SE = 5'd24;
       31'b00000000000000000000000001xxxxx: SE = 5'd25;
       31'b000000000000000000000000001xxxx: SE = 5'd26;
       31'b0000000000000000000000000001xxx: SE = 5'd27;
       31'b00000000000000000000000000001xx: SE = 5'd28;
       31'b000000000000000000000000000001x: SE = 5'd29;
       31'b0000000000000000000000000000001: SE = 5'd30;
       31'b0000000000000000000000000000000: SE = 5'd31;
     endcase
     end
   endfunction
    
   assign l = SE(i_abs);
   wire [7:0] e;
   wire [22:0] m;

   assign [30:0] tmp_i;
   assign tmp_i = i_abs << (l + 5'd1);

   assign m = tmp_i[30:8];
   assign e = 8'd157 - {3'd0, l};

   assign y = (i == 0) ? 32'd0 :
              (x == 32'd4294967295) ? {1'b1, 8'd0, 23'd158} : {s, e, m};

endmodule

`default_nettype wire
