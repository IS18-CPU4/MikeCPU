`timescale 1ns / 100ps
`default_nettype none

module test_fsqrt_p2
  #(parameter NSTAGE = 2)
   ();
   wire [31:0] x,y;
   wire        ovf;
   shortreal    fx,fy;
   bit [7:0]    e;
   int          i,j,k,it,jt;
   bit [22:0]   m;
   bit [22:0]   dum;
   logic [31:0] fybit;
   int          s;
   logic [23:0] dy;
   bit [22:0] 	tm;
   logic 	fovf;
   bit 		checkovf;

   logic 	clk;
   logic 	rstn;

   logic [31:0]	x_reg[NSTAGE:0];
   logic 	val[NSTAGE:0];

   assign x = x_reg[0];

   fsqrt_p2 u1(x,y,clk,rstn);

   initial begin
      // $dumpfile("test_fadd_p2.vcd");
      // $dumpvars(0);
      #1;
      rstn = 0;
      clk = 1;
      val = {default: 1'b0};
      x_reg[0] = 0;

      #1;
      clk = 0;
      #1;
      clk = 1;
      rstn = 1;
      
      #1;
      clk = 0;
      #1;
      clk = 1;

      for (i=0; i<1024*1024*8; i++) begin // 0 ~ 2^23-1
        m = i[22:0];
        {s, e, dum} = {1'b0, 8'd99, 23'd1}; //e=odd version
        x_reg[0] <= {s, e, m};
			  val[0] <= 1;


        #1;
			  clk = 0;
			  #1;
			  clk = 1;
      end

      for (i=0; i<1024*1024*8; i++) begin // 0 ~ 2^23-1
        m = i[22:0];
        {s, e, dum} = {1'b0, 8'd160, 23'd1}; //e=odd version
        x_reg <= {s, e, m};
			  val[0] <= 1;


        #1;
			  clk = 0;
			  #1;
			  clk = 1;
      end
      $finish;
   end

   always @(posedge clk) begin
      x_reg[NSTAGE:1] <= x_reg[NSTAGE-1:0];
      val[NSTAGE:1] <= val[NSTAGE-1:0];
   end
   
   always @(posedge clk) begin
      if (val[NSTAGE]) begin
        fx = $bitstoshortreal(x_reg[NSTAGE]);
        fy = $sqrt(fx);
        fybit = $shortrealtobits(fy);
        
        if (!(y+32'd5 > fybit && y-32'd5 < fybit)) begin
           $display("x      =%e  %b", $bitstoshortreal(x), x);
           $display("true y =%e  %b ", fy, $shortrealtobits(fy));
           $display("my   y =%e  %b \n", $bitstoshortreal(y), y);
        end
      end
   end
endmodule

`default_nettype wire
