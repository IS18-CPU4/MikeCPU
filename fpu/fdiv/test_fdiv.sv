`timescale 1ns / 100ps
`default_nettype none

module test_fdiv();
   wire [31:0] x1,x2,y;
   logic [31:0] x1i, x2i;
   shortreal    fx1, fx2, fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1, m2;
   bit [22:0]    dum1, dum2;
   logic [31:0] fybit;
   int          s1, s2;
   logic [23:0] dy;
   bit [22:0] tm;


   assign x1 = x1i;
   assign x2 = x2i;
   
   fdiv u1(x1,x2,y);

   initial begin
      // $dumpfile("test_finv.vcd");
      // $dumpvars(0);
      
      for (i=0; i<254; i++) begin
         for (j=1; j<254; j++) begin
            for (s1=0; s1<2; s1++) begin
               for (s2=0; s2<2; s2++) begin
                  for (it=0; it<30; it++) begin
                     for (jt=0; jt<30; jt++) begin
                        #1;
                        
                        case (it)
                          0 : m1 = 23'b0;
                          1 : m1 = {22'b0,1'b1};
                          2 : m1 = {21'b0,2'b10};
                          3 : m1 = {1'b0,3'b111,19'b0};
                          4 : m1 = {1'b1,22'b0};
                          5 : m1 = {2'b10,{21{1'b1}}};
                          6 : m1 = {23{1'b1}};
                          default : begin
                             m1 = $urandom();
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
                             m2 = $urandom();
                          end                          
                        endcase
                        
                        x1i = {s1[0],i[7:0],m1};
                        x2i = {s2[0],j[7:0],m2};

                        fx1 = $bitstoshortreal(x1i);
                        fx2 = $bitstoshortreal(x2i);
                        fy = fx1 / fx2;
                        fybit = $shortrealtobits(fy);                        
                              
                        #1;

                       if (x1i[30:23] == 8'd0) begin 
                          if (y[30:23] != 8'd0) begin
                              $display("x1 = %b", x1);
                              $display("x2 = %b", x2);                              
                              $display("%e true y   = %b ", fy, $shortrealtobits(fy));
                              $display("%e module y = %b \n", $bitstoshortreal(y),y);
                           end
                       end else begin
                        if (fybit[30:23] < 8'd254) begin
                  //正しい出力の指数部が0な場合は出力の指数部も0であることが必要十分    
                          if (fybit[30:23] == 8'd0) begin
                            if(y[30:23] != fybit[30:23]) begin
                              $display("x1 = %b", x1);
                              $display("x2 = %b", x2);                              
                              $display("%e true y   = %b ", fy, $shortrealtobits(fy));
                              $display("%e module y = %b \n", $bitstoshortreal(y), y);
                            end
                          end else begin 
                             if(y + 32'd8 < fybit || fybit < y - 32'd8) begin
                              $display("x1 = %b", x1);
                              $display("x2 = %b", x2);                              
                              $display("%e true y   = %b ", fy, $shortrealtobits(fy));
                              $display("%e module y = %b \n", $bitstoshortreal(y), y);
                            end                           
                          end 
                        end
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
