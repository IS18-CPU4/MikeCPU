`timescale 1ns / 100ps
`default_nettype none

module test_finv();
   wire [31:0] x,y;
   wire        ovf;
   logic [31:0] xi;
   shortreal    fx,fy;
   int          i,k,it;
   bit [22:0]   m;
   bit [9:0]    dum;
   logic [31:0] fybit;
   int          s;
   logic [23:0] dy;
   bit [22:0] tm;
   bit 	      fovf;
   bit 	      checkovf;

   assign x = xi;
   
   finv u1(x,y,ovf);

   initial begin
      // $dumpfile("test_finv.vcd");
      // $dumpvars(0);

      for (i=1; i<255; i++) begin // xの指数部 0,255にならないようにした
         for (s=0; s<2; s++) begin // x1の符号
            for (it=0; it<10; it++) begin
                     #1;

                     case (it) // xの仮数部
                       0 : m = 23'b0;
                       1 : m = {22'b0,1'b1};
                       2 : m = {21'b0,2'b10};
                       3 : m = {1'b0,3'b111,19'b0};
                       4 : m = {1'b1,22'b0};
                       5 : m = {2'b10,{21{1'b1}}};
                       6 : m = {23{1'b1}};
                       default : begin
                          if (i==256) begin
                             {m,dum} = 0;
                          end else begin
                             {m,dum} = $urandom();
                          end
                       end
                     endcase

                     xi = {s[0],i[7:0],m};

                     fx = $bitstoshortreal(xi);
                     fy = 1 / fx; // inverse
                     fybit = $shortrealtobits(fy);

                     checkovf = i < 255;
                     if ( checkovf && fybit[30:23] == 255 ) begin
                        fovf = 1;
                     end else begin
                        fovf = 0;
                     end
                     
                     #1;

                     if (fybit[30:23] === 0 || (fybit[30:23] === 23'd1 && fybit[22:0] === 23'd0)) begin
                        if (!(y === 0 || y[30:0] === fybit[30:0])) begin
                           $display("x = %b", x);
                           $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
                        end
                     end else begin
                        if (!(y+32'd1 === fybit || y === fybit || y-32'd1 === fybit) || ovf !== fovf) begin
                           $display("x = %b", x);
                           $display("%e %b %b", fy, $shortrealtobits(fy), fovf);
                           $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
                        end
                     end
            end
         end
      end
      /* do not need below maybe haha
      for (i=1; i<255; i++) begin // 1-254にした
         for (s1=0; s1<2; s1++) begin
            for (s2=0; s2<2; s2++) begin
               for (j=0;j<23;j++) begin
                  repeat(10) begin
                     #1;

                     {m1,dum1} = $urandom();
                     x1i = {s1[0],i[7:0],m1};
                     {m2,dum2} = $urandom();
                     for (k=0;k<j;k++) begin
                        tm[k] = m2[k];
                     end
                     for (k=j;k<23;k++) begin
                        tm[k] = m1[k];
                     end
                     x2i = {s2[0],i[7:0],tm};

                     fx1 = $bitstoshortreal(x1i);
                     fx2 = $bitstoshortreal(x2i);
                     fy = fx1 * fx2; // + -> *
                     fybit = $shortrealtobits(fy);
                     
                     checkovf = i < 255;
                     if (checkovf && fybit[30:23] == 255) begin
                        fovf = 1;
                     end else begin
                        fovf = 0;
                     end

                     #1;
                     if (fybit[30:23] === 0 || (fybit[30:23] === 23'd1 && fybit[22:0] === 23'd0)) begin
                        if (!(y === 0 || y[30:0] === fybit[30:0])) begin
                           $display("x1, x2 = %b %b", x1, x2);
                           $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
                        end
                     end else begin
                        if (!(y+32'd1 === fybit || y === fybit || y-32'd1 === fybit) || ovf !== fovf) begin
                           $display("x1, x2 = %b %b", x1, x2);
                           $display("%e %b %b", fy, $shortrealtobits(fy), fovf);
                           $display("%e %b %b\n", $bitstoshortreal(y), y, ovf);
                        end
                     end                  
                  end
               end
            end
         end
      end
      */
      $finish;
   end
endmodule

`default_nettype wire
