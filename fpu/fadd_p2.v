`default_nettype none

module fadd_p2
   ( input wire [31:0] x1,
     input wire [31:0] x2,
     output reg [31:0] y,
     output reg ovf,
     input wire clk,
     input wire rstn);

   // 1
   reg s1_r,s2_r;
   reg [7:0] e1_r, e2_r;
   reg [22:0] m1_r, m2_r;
   wire s1, s2;
   wire [7:0] e1, e2;
   wire [22:0] m1, m2;
   assign {s1, e1, m1} = x1;
   assign {s2, e2, m2} = x2;

   // 2
   wire [24:0] m1a, m2a;
   assign m1a = (e1 == 8'd0) ? {2'b0, m1} : {2'b1, m1};
   assign m2a = (e2 == 8'd0) ? {2'b0, m2} : {2'b1, m2};

   // 3
   wire [7:0] e1a, e2a;
   assign e1a = (e1 == 8'd0) ? 8'd1 : e1;
   assign e2a = (e2 == 8'd0) ? 8'd1 : e2;

   // 4
   wire [7:0] e2ai;
   assign e2ai = ~e2a;

   // 5
   wire [8:0] te;
   assign te = {1'b0, e1a} + {1'b0, e2ai};

   // 6
   wire ce;
   wire [7:0] tde;
   assign ce = (te[8] == 1'b1) ? 0 : 1;
   wire [8:0] tmp1;
   wire [7:0] tmp2;
   assign tmp1 = te + 1;
   assign tmp2 = ~te;
   assign tde = (te[8] == 1'b1) ? tmp1[7:0] : tmp2[7:0];

   // 7
   wire [4:0] de;
   assign de = (|(tde[7:5])) ? 5'd31 : tde[4:0];

   // 8
   wire sel;
   assign sel = (de == 5'b0) ? ((m1a > m2a) ? 0 : 1) : ce;

   // 9
   reg ss_r;
   wire [24:0] ms, mi;
   wire [7:0] es, ei;
   wire ss;
   assign ms = (sel == 1'b0) ? m1a : m2a;
   assign mi = (sel == 1'b0) ? m2a : m1a;
   assign es = (sel == 1'b0) ? e1a : e2a;
   assign ei = (sel == 1'b0) ? e2a : e1a;
   assign ss = (sel == 1'b0) ? s1 : s2;

   // 10
   wire [55:0] mie;
   assign mie = {mi, 31'b0};

   // 11
   wire [55:0] mia;
   assign mia = mie >> de;

   // 12
   wire tstck;
   assign tstck = |(mia[28:0]);

   // 13
   reg [26:0] mye_r;
   wire [26:0] mye;
   assign mye = (s1 == s2) ? {ms, 2'b0} + mia[55:29] : {ms, 2'b0} - mia[55:29];

   // 14
   reg [7:0] esi_r;
   wire [7:0] esi;
   assign esi = es + 1;

   // 15
   reg [7:0] eyd_r;
   reg [26:0] myd_r;
   reg stck_r;
   wire [7:0] eyd;
   wire [26:0] myd;
   wire stck;
   assign eyd = (mye[26] == 1'b1) ? ((esi == 255) ? 255 : esi) : es;
   assign myd = (mye[26] == 1'b1) ? ((esi == 255) ? {2'b01, 25'b0} : mye >> 1) : mye;
   assign stck = (mye[26] == 1'b1) ? tstck || mye[0] : tstck;

   // 16
   reg [4:0] se_r;
   wire [4:0] se;
   priority_encoder pe(myd, se);

   // ここできる

   // 17
   wire signed [8:0] eyf;
   assign eyf = $signed({1'b0,eyd_r}) - $signed({4'b0,se_r});

   // 18
   wire [7:0] eyr;
   wire [26:0] myf;
   assign myf = ($signed(eyf) > $signed(8'b0)) ? myd_r << se_r : myd_r << (eyd_r[4:0]-1);
   assign eyr = ($signed(eyf) > $signed(8'b0)) ? eyf[7:0] : 8'b0;

   // 19
   wire [24:0] myr;
   assign myr = ((myf[1] == 1 && myf[0] == 0 & stck_r == 0 && myf[2] == 1) || (myf[1] == 1 && myf[0] == 0 && s1_r == s2_r && stck_r == 1) || myf[1] == 1 && myf[0] == 1) ? myf[26:2] + 25'b1 : myf[26:2];

   // 20
   wire [7:0] eyri;
   assign eyri = eyr + 8'b1;

   // 21
   wire [7:0] ey;
   wire [22:0] my;
   assign ey = (myr[24] == 1) ? eyri : ((myr[23:0] == 24'b0) ? 0 : eyr);
   assign my = (myr[24] == 1) ? 23'b0 : ((myr[23:0] == 24'b0) ? 23'b0 : myr[22:0]);

   // 22
   wire sy;
   assign sy = (ey == 0 && my == 0) ? s1_r && s2_r : ss_r;

   // 23
   wire nzm1, nzm2;
   assign nzm1 = |(m1_r[22:0]);
   assign nzm2 = |(m2_r[22:0]);

   wire [31:0] y_w;
   wire ovf_w;
   assign y_w = (e1_r == 255 && e2_r != 255) ? {s1_r,8'd255,nzm1,m1_r[21:0]} : ((e2_r == 255 && e1_r != 255) ? {s2_r,8'd255,nzm2,m2_r[21:0]} : ((e1_r == 255 && e2_r == 255 && nzm2) ? {s2_r,8'd255,1'b1,m2_r[21:0]} : ((e1_r == 255 && e2_r == 255 && nzm1) ? {s1_r,8'd255,1'b1,m1_r[21:0]} : ((e1_r == 255 && e2_r == 255 && s1_r==s2_r) ? {s1_r,8'd255,23'b0} : ((e1_r == 255 && e2_r == 255) ? {1'b1,8'd255,1'b1,22'b0} : {sy,ey,my})))));
   assign ovf_w = (e1_r != 255 && e2_r != 255) ? ((mye_r[26] == 1'b1 && esi_r == 255) ? 1 : ((myr[24] == 1 && eyri == 255) ? 1 : 0)) : 0;

   always @(posedge clk) begin
     if (~rstn) begin
       y <= 0;
       ovf <= 0;
       eyd_r <= 0;
       se_r <= 0;
       myd_r <= 0;
       stck_r <= 0;
       s1_r <= 0;
       s2_r <= 0;
       ss_r <= 0;
       m1_r <= 0;
       m2_r <= 0;
       e1_r <= 0;
       e2_r <= 0;
       mye_r <= 0;
       esi_r <= 0;
     end else begin
       y <= y_w;
       ovf <= ovf_w;
       eyd_r <= eyd;
       se_r <= se;
       myd_r <= myd;
       stck_r <= stck;
       s1_r <= s1;
       s2_r <= s2;
       ss_r <= ss;
       m1_r <= m1;
       m2_r <= m2;
       e1_r <= e1;
       e2_r <= e2;
       mye_r <= mye;
       esi_r <= esi;
     end
   end

endmodule

module priority_encoder
   ( input wire [26:0] myd,
     output wire [4:0] se);

   assign se = (myd[25] == 1) ? 5'b00000 :
               (myd[24] == 1) ? 5'b00001 :
               (myd[23] == 1) ? 5'b00010 :
               (myd[22] == 1) ? 5'b00011 :
               (myd[21] == 1) ? 5'b00100 :
               (myd[20] == 1) ? 5'b00101 :
               (myd[19] == 1) ? 5'b00110 :
               (myd[18] == 1) ? 5'b00111 :
               (myd[17] == 1) ? 5'b01000 :
               (myd[16] == 1) ? 5'b01001 :
               (myd[15] == 1) ? 5'b01010 :
               (myd[14] == 1) ? 5'b01011 :
               (myd[13] == 1) ? 5'b01100 :
               (myd[12] == 1) ? 5'b01101 :
               (myd[11] == 1) ? 5'b01110 :
               (myd[10] == 1) ? 5'b01111 :
               (myd[9] == 1) ? 5'b10000 :
               (myd[8] == 1) ? 5'b10001 :
               (myd[7] == 1) ? 5'b10010 :
               (myd[6] == 1) ? 5'b10011 :
               (myd[5] == 1) ? 5'b10100 :
               (myd[4] == 1) ? 5'b10101 :
               (myd[3] == 1) ? 5'b10110 :
               (myd[2] == 1) ? 5'b10111 :
               (myd[1] == 1) ? 5'b11000 :
               (myd[0] == 1) ? 5'b11001 : 5'b11010;

endmodule

`default_nettype wire
