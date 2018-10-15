`define OP_li       6'd0
`define OP_mr       6'd1
`define OP_addi     6'd2
`define OP_add      6'd3
`define OP_sub      6'd4
`define OP_st       6'b011010
`define OP_out      6'b111111

`define OP_b        6'd14


`define COM_li(rD, simm16)       {`OP_li,   rD,   5'd0, simm16     }
`define COM_mr(rD, rA)           {`OP_mr,   rD,   rA,   16'd0      }
`define COM_addi(rD, rA, simm16) {`OP_addi, rD,   rA,   simm16     }
`define COM_add(rD, rA, rB)      {`OP_add,  rD,   rA,   rB,  11'd0 }
`define COM_sub(rD, rA, rB)      {`OP_sub,  rD,   rA,   rB,  11'd0 }
`define COM_st(rS, rA, simm16)   {`OP_st,   rS,   rA,   simm16     }
`define COM_out(rS)              {`OP_out,  rS,   21'd0            }

`define COM_b(simm26)            {`OP_b,    simm26                 }

`define A_COM_nop 4'd0
`define A_COM_add 4'd1
`define A_COM_sub 4'd2


module Alu(
  input wire [31:0] rA,
  input wire [31:0] rB,
  input wire [3:0] command,
  output wire [31:0] rD
);
  function [31:0] out;
    input [31:0] a;
    input [31:0] b;
    input [3:0] com;

    begin
      case (command)
        `A_COM_nop: out = a;
        `A_COM_add: out = a + b;
        `A_COM_sub: out = a - b;
        default: out = 0;
      endcase
    end
  endfunction

  assign rD = out(rA, rB, command);
endmodule

`define IO_WRITE_ADDR_OFFSET 32'h00FFFF00
module Controller(
  input wire [31:0] mem_rdata,
  output reg [31:0] mem_wdata,
  output reg [31:0] mem_addr,
  output reg [3:0] mem_wenable,
  output reg mem_enable,

  input wire [0:31] inst,  // latency 1
  output wire [31:0] mem_inst_addr,
  output wire mem_inst_enable,

  output reg io_read_req,
  output reg io_write_req,
  input wire io_ready,
  input wire io_done,
  output reg [7:0] io_wdata,
  input wire [7:0] io_rdata,

  input wire boot,
  output reg [7:0] err,
  
  input wire CLK,
  input wire RSTN
);
  
  reg [31:0] pc;
  assign mem_inst_addr = {pc[29:0], 2'b00};
  assign mem_inst_enable = 1'b1;
  wire [5:0] inst_op;
  wire [4:0] inst_rD;
  wire [4:0] inst_rA;
  wire [4:0] inst_rB;
  wire [4:0] inst_imm5;
  wire [15:0] inst_imm16;
  wire [25:0] inst_imm26;
  assign {inst_op, inst_rD, inst_rA, inst_rB} = inst[0:20];
  assign inst_imm5 = inst[16:20];
  assign inst_imm16 = inst[16:31];
  assign inst_imm26 = inst[6:31];

  reg [31:0] _register [0:31];
  function [31:0] register (input [4:0] reg_num);
    register = (reg_num == 5'd0) ? 32'd0 : _register[reg_num];
  endfunction
  reg [31:0] rA;
  reg [31:0] rB;
  wire [31:0] rD;
  reg [3:0] command;
  reg [31:0] save_reg;
  Alu int_alu(rA, rB, command, rD);

  function [31:0] simm16_32 (
    input [0:15] simm16
  );
    simm16_32 = simm16[0] ? {16'hFFFF, simm16} : {16'h0, simm16};
  endfunction

  function [31:0] simm26_32 (
    input [0:25] simm26
  );
    simm26_32 = simm26[0] ? {6'b111111, simm26} : {6'h0, simm26};
  endfunction

  localparam [2:0] s_init   = 3'b000;
  localparam [2:0] s_fetch  = 3'b001;
  localparam [2:0] s_decode = 3'b010;
  localparam [2:0] s_exec   = 3'b011;
  localparam [2:0] s_write  = 3'b100;
  localparam [2:0] s_io     = 3'b101;
  localparam [2:0] s_halt   = 3'b111;
  reg [2:0] state;

  
  always @(posedge CLK) begin
    if (~RSTN) begin
      mem_wdata <= 0;
      mem_enable <= 0;
      mem_wenable <= 0;
      mem_addr <= 0;

      io_read_req <= 0;
      io_write_req <= 0;
      io_wdata <= 0;

      rA <= 0;
      rB <= 0;
      command <= `A_COM_nop;
      save_reg <= 0;

      _register[0] <= 32'd0;

      state <= s_init;
      pc <= 0;
    end else begin
      case (state)
        s_init: begin
          if (boot) begin
            pc <= 0;
            state <= s_fetch;
          end
        end
        s_fetch: begin
          save_reg <= 0;
          command <= 0;
          rA <= 0;
          rB <= 0;
          state <= s_decode;
        end
        s_decode: begin
          err <= _register[5'd3];
          state <= s_exec;
          // now inst_** are valid
          case (inst_op)
            `OP_li: begin
              rA <= simm16_32(inst_imm16);
              command <= `A_COM_nop;
              save_reg <= inst_rD;
            end
            `OP_add: begin
              rA <= register(inst_rA);
              rB <= register(inst_rB);
              command <= `A_COM_add;
              save_reg <= inst_rD;
            end
            `OP_addi: begin
              rA <= register(inst_rA);
              rB <= simm16_32(inst_imm16);
              command <= `A_COM_add;
              save_reg <= inst_rD;
            end
            `OP_mr: begin
              rA <= register(inst_rA);
              command <= `A_COM_nop;
              save_reg <= inst_rD;
            end
            `OP_b: begin
              rA <= pc;
              rB <= simm26_32(inst_imm26);
              command <= `A_COM_add;
              save_reg <= 5'd0;
            end
            `OP_st: begin
              rA <= register(inst_rA);
              rB <= simm16_32(inst_imm16);
              save_reg <= 5'd0;
            end
            `OP_out: rA <= register(inst_rD);
          endcase
        end
        s_exec: begin
          // now ALU output is valid
          if (save_reg != 5'd0) _register[save_reg] <= rD;
          if (inst_op == `OP_st) begin
            mem_wdata <= register(inst_rD);
            mem_addr <= {2'b00, rD[31:2]};
            mem_wenable <= 4'b1111;
            mem_enable <= 1'b1;
          end
          if (inst_op == `OP_out) begin
            io_wdata <= rA[7:0];
            io_write_req <= 1'b1;
            state <= s_io;
          end
          else state <= s_write;
        end
        s_write: begin
          if (inst_op == `OP_b) pc <= rD;
          else pc <= pc + 32'd1;

          if (mem_enable) begin
            mem_wenable <= 4'd0;
            mem_enable <= 1'b0;
          end

          state <= s_fetch;
        end
        s_io: begin
          io_write_req <= 1'b0;
          io_read_req <= 1'b0;
          if (io_done) begin
            pc <= pc + 32'd1;
            state <= s_fetch;
          end
        end
        s_halt: begin
          err <= 8'hFF;
          state <= state;
        end
      endcase
    end
  end
endmodule
