`timescale 1ns / 100ps
`default_nettype none

module test_fmul
  #(parameter NSTAGE = 3)
   ();
   wire [31:0] x1,x2,y;
   wire        ovf;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] 	tm;
   logic 	fovf;
   bit 		checkovf;

   logic 	clk;
   logic 	rstn;

   logic [31:0]	x1_reg[NSTAGE:0];
   logic [31:0]	x2_reg[NSTAGE:0];
   logic 	val[NSTAGE:0];

   assign x1 = x1_reg[0];
   assign x2 = x2_reg[0];

   fmul u1(x1,x2,y,ovf,clk,rstn);

   initial begin
      // $dumpfile("test_fmul.vcd");
      // $dumpvars(0);
      #1;
      rstn = 0;
      clk = 1;
      val = {default: 1'b0};
      x1_reg[0] = 0;
      x2_reg[0] = 0;

      #1;
      clk = 0;
      #1;
      clk = 1;
      rstn = 1;
      
      #1;
      clk = 0;
      #1;
      clk = 1;

      for (i=0; i<256; i++) begin
         for (j=0; j<256; j++) begin
            for (s1=0; s1<2; s1++) begin
               for (s2=0; s2<2; s2++) begin
                  for (it=0; it<10; it++) begin
                     for (jt=0; jt<10; jt++) begin
                        case (it)
                          0 : m1 = 23'b0;
                          1 : m1 = {22'b0,1'b1};
                          2 : m1 = {21'b0,2'b10};
                          3 : m1 = {1'b0,3'b111,19'b0};
                          4 : m1 = {1'b1,22'b0};
                          5 : m1 = {2'b10,{21{1'b1}}};
                          6 : m1 = {23{1'b1}};
                          default : begin
                             if (i==256) begin
                                {m1,dum1} = 0;
                             end else begin
                                {m1,dum1} = $urandom();
                             end
                          end
                        endcase

                        case (jt)
                          0 : m2 = 23'b0;
                          1 : m2 = {22'b0,1'b1};
                          2 : m2 = {21'b0,2'b10};
                          3 : m2 = {1'b0,3'b111,19'b0};
                          4 : m2 = {1'b1,22'b0};
                          5 : m2 = {2'b10,{21{1'b1}}};
                          6 : m2 = {23{1'b1}};
                          default : begin
                             if (i==256) begin
                                {m2,dum2} = 0;
                             end else begin
                                {m2,dum2} = $urandom();
                             end
                          end
                        endcase
                        
                        x1_reg[0] <= {s1[0],i[7:0],m1};
                        x2_reg[0] <= {s2[0],j[7:0],m2};
			val[0] <= 1;

                        #1;
			clk = 0;
			#1;
			clk = 1;
                     end
                  end
               end
            end
         end
      end

      for (i=0; i<255; i++) begin
         for (s1=0; s1<2; s1++) begin
            for (s2=0; s2<2; s2++) begin
               for (j=0;j<23;j++) begin
                  repeat(10) begin

                     {m1,dum1} = $urandom();
                     x1_reg[0] <= {s1[0],i[7:0],m1};
                     {m2,dum2} = $urandom();
                     for (k=0;k<j;k++) begin
                        tm[k] = m2[k];
                     end
                     for (k=j;k<23;k++) begin
                        tm[k] = m1[k];
                     end
                     x2_reg[0] <= {s2[0],i[7:0],tm};
		     val[0] <= 1;

                     #1;
		     clk = 0;
		     #1;
		     clk = 1;
                  end
               end
            end
         end
      end
      $finish;
   end

   always @(posedge clk) begin
      x1_reg[NSTAGE:1] <= x1_reg[NSTAGE-1:0];
      x2_reg[NSTAGE:1] <= x2_reg[NSTAGE-1:0];
      val[NSTAGE:1] <= val[NSTAGE-1:0];
   end
   
   always @(posedge clk) begin
      if (val[NSTAGE]) begin
	 fx1 = $bitstoshortreal(x1_reg[NSTAGE]);
	 fx2 = $bitstoshortreal(x2_reg[NSTAGE]);
	 fy = fx1 * fx2;  // + to *
	 fybit = $shortrealtobits(fy);
	 checkovf = x1_reg[NSTAGE][30:23] < 255 && x2_reg[NSTAGE][30:23] < 255;
	 if ( checkovf && fybit[30:23] == 255 ) begin
	    fovf = 1;
	 end else begin
	    fovf = 0;
	 end

	 if (y !== fybit || ovf !== fovf) begin
            $display("x1, x2 = %b %b", x1_reg[NSTAGE], x2_reg[NSTAGE]);
            $display("%e %b %b", fy, fybit, fovf);
            $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
	 end
      end
   end
endmodule

`default_nettype wire
