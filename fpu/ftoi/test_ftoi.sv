`timescale 1ns / 100ps
`default_nettype none

module test_ftoi();
   wire [31:0] x1,x2,y;
   wire        ovf;
   logic [31:0] x1i,x2i;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;
   bit 	      fovf;
   bit 	      checkovf;

   assign x1 = x1i;
   
   ftoi u1(x1,y,ovf);

   initial begin
      // $dumpfile("test_fmul.vcd");
      // $dumpvars(0);

      for (i=1; i<255; i++) begin // x1の指数部 0,255にならないようにした
            for (s1=0; s1<2; s1++) begin // x1の符号
                  for (it=0; it<10; it++) begin
                        #1;

                        case (it) // x1の仮数部
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

                        x1i = {s1[0],i[7:0],m1};

                        fx1 = $bitstoshortreal(x1i);
                        fybit = $rtoi(real'(fx1));

                        checkovf = (i[7:0] >= 8'd158);
                        if ( checkovf ) begin
                           fovf = 1;
                        end else begin
                           fovf = 0;
                        end
                        
                        #1;

                        if (!(fybit === y && fovf === ovf)) begin
                           $display("x = %b", x1);
                           $display("%b %b\n", fybit, fovf);
                           $display("%b %b\n", y, ovf);
                        end
                     end
                  end
               end
            end
         end
      end
      $finish;
   end
endmodule

`default_nettype wire
