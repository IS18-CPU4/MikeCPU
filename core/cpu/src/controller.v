`define OP_li       6'd0
`define OP_mr       6'd1
`define OP_addi     6'd2
`define OP_add      6'd3
`define OP_sub      6'd4

`define OP_b        6'd14

`define OP_out      6'd29

`define COM_li(rD, simm16)       {`OP_li,   rD,   5'd0, simm16     }
`define COM_mr(rD, rA)           {`OP_mr,   rD,   rA,   16'd0      }
`define COM_addi(rD, rA, simm16) {`OP_addi, rD,   rA,   simm16     }
`define COM_add(rD, rA, rB)      {`OP_add,  rD,   rA,   rB,  11'd0 }
`define COM_sub(rD, rA, rB)      {`OP_sub,  rD,   rA,   rB,  11'd0 }

`define COM_b(simm26)            {`OP_b,    simm26                 }

`define COM_out(rA)              {`OP_out,  rA,   5'd0, 16'd0      }

`define A_COM_nop 4'd0
`define A_COM_add 4'd1
`define A_COM_sub 4'd2


module Alu(
  input wire [31:0] rA,
  input wire [31:0] rB,
  input wire [3:0] command,
  output wire [31:0] rD,
  input wire CLK,
  input wire RSTN
);
  always @(posedge CLK) begin
    if (~RSTN) begin
      rD <= 0;
    end else begin
      case (command)
        `A_COM_nop: rD <= rA;
        `A_COM_add: rD <= rA + rB;
        `A_COM_sub: rD <= rA - rB;
        default: rD <= 0;
      endcase
    end
  end
endmodule

`define IO_ADDR_OFFSET 32'h00FFFF00
module IObuf(
  input wire io_read_req,
  input wire io_write_req,
  output wire io_ready,
  output wire io_done,
  input wire [31:0] din,
  output wire [31:0] dout,
  input wire CLK,
  output wire RSTN
);
  localparam [2:0] s_init =  3'b000;
  localparam [2:0] s_idle =  3'b001;
  localparam [2:0] s_chkRx = 3'b010;
  localparam [2:0] s_read =  3'b011;
  localparam [2:0] s_chkTx = 3'b100;
  localparam [2:0] s_write = 3'b101;
  reg [2:0] state;

  reg [31:0] req_data;

  always @(posedge CLK) begin
    if (~RSTN) begin
      io_done <= 0;
      io_ready <= 0;
      dout <= 0;
      state <= s_init;
      req_data <= 0;
    end else begin
      case (state)
        s_init: begin
          io_ready <= 1'b1;
          state <= s_idle;
        end
        s_idle:
          if (io_read_req) begin
            io_ready <= 0;
        s_chkRx:
        s_read:
        s_chkTx:
        s_write:
    end
endmodule
module Controller(
  input wire [31:0] mem_rdata,
  output wire [31:0] mem_wdata,
  input wire mem_wenable,
  input wire mem_enable,

  input wire io_done,
  output wire io_read_req,
  output wire io_write_req,
  input wire [31:0] io_rdata,
  output wire [31:0] io_wdata,

  input wire CLK,
  input wire RSTN
);