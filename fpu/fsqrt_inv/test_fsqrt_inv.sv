`timescale 1ns / 100ps
`default_nettype none

module test_fsqrt_inv();
   wire [31:0] x,y;
   wire        ovf;
   logic [31:0] xi;
   shortreal    fx,fy;
   int          i,k,it;
   bit [22:0]   m;
   bit [7:0]    e;
   bit [22:0]    dum;
   logic [31:0] fybit;
   int          s;
   logic [23:0] dy;
   bit [22:0] tm;


   assign x = xi;
   
   fsqrt_inv u1(x,y,ovf);

   // for inv 1<=m<=2^23-1 because when m=0 fsqrt behaves differently
   initial begin
      // $dumpfile("test_finv.vcd");
      // $dumpvars(0);
      /*
      for (i=1; i<1024*1024*8; i++) begin // 1 ~ 2^23-1
        #1;
        m = i[22:0];
        {s, e, dum} = {1'b0, 8'd99, 23'd1}; //e=odd version
        xi = {s,e,m};

        fx = $bitstoshortreal(xi);
        fy = 1 / $sqrt(fx);
        fybit = $shortrealtobits(fy);

        
        #1;

           if (!(y+32'd5 > fybit && y-32'd5 < fybit)) begin
              $display("x      =%e  %b", $bitstoshortreal(x), x);
              $display("true y =%e  %b ", fy, $shortrealtobits(fy));
              $display("my   y =%e  %b \n", $bitstoshortreal(y), y);
           end else begin
              $display("succeeded");
           end
        end
      */
      
      for (i=1; i<1024*1024*8; i++) begin // 1 ~ 2^23-1 
        #1;
        m = i[22:0];
        {s, e, dum} = {1'b0, 8'd160, 23'd1};//e=even version
        xi = {s,e,m};

        fx = $bitstoshortreal(xi);
        fy = 1 / $sqrt(fx);
        fybit = $shortrealtobits(fy);

        
        #1;

           if (!(y+32'd5 > fybit && y-32'd5 < fybit)) begin
              $display("x      =%e  %b", $bitstoshortreal(x), x);
              $display("true y =%e  %b ", fy, $shortrealtobits(fy));
              $display("my   y =%e  %b \n", $bitstoshortreal(y), y);
           end
        end
        
      $finish;
   end
endmodule

`default_nettype wire
