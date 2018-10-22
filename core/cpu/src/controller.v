`define OP_li       6'd0
`define OP_mr       6'd1
`define OP_addi     6'd2
`define OP_add      6'd3
`define OP_sub      6'd4
`define OP_slwi     6'd5
`define OP_srwi     6'd6

`define OP_slw      6'd7  // temporal
`define OP_srw      6'd8  // temporal

`define OP_b        6'd14
`define OP_beq      6'd15
`define OP_bne      6'd16
`define OP_blt      6'd17
`define OP_bl       6'd18
`define OP_blr      6'd19

`define OP_mflr     6'd20
`define OP_mtlr     6'd21

`define OP_cmpwi    6'd22
`define OP_cmpw     6'd23

`define OP_ld       6'b011001
`define OP_st       6'b011010


`define OP_in      6'b111110
`define OP_out      6'b111111



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
`define A_COM_sll 4'd3
`define A_COM_srl 4'd4

`define ERR_C_INVALID_STATE 8'b1000_0000
`define ERR_C_INVALID_OP    8'b0100_0000
`define ERR_C_HALT          8'b0000_0001


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
        `A_COM_sll: out = a << b;
        `A_COM_srl: out = a >> b;
        `A_COM_sub: out = a - b;
        default: out = 0;
      endcase
    end
  endfunction

  assign rD = out(rA, rB, command);
endmodule

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
  reg [31:0] jump_pc;
  reg will_jump;

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

  reg reg_we;
  reg [31:0] reg_wdata;
  wire [31:0] rA;
  wire [31:0] rB;
  wire [31:0] rD;
  RegisterFile register(inst_rD, inst_rA, inst_rB, rD, rA, rB, 
    reg_we, reg_wdata, CLK);

  reg [0:3] condreg;
  wire c0_lt, c0_gt, c0_eq, c0_of;
  assign {c0_lt, c0_gt, c0_eq, c0_of} = condreg;

  reg [31:0] linkreg;

  reg [3:0] command;
  reg use_imm;
  reg [31:0] imm;
  wire [31:0] alu_in0, alu_in1, alu_out;
  assign alu_in0 = rA;
  assign alu_in1 = use_imm ? imm : rB;
  Alu int_alu(alu_in0, alu_in1, command, alu_out);

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
  localparam [2:0] s_i      = 3'b101;
  localparam [2:0] s_o      = 3'b110;
  localparam [2:0] s_halt   = 3'b111;
  reg [2:0] state;

  
  always @(posedge CLK) begin
    if (~RSTN) begin
      reg_we <= 0;
      reg_wdata <= 0;
      condreg <= 0;
      linkreg <= 0;

      use_imm <= 0;
      imm <= 0;
      command <= `A_COM_nop;

      mem_wdata <= 0;
      mem_enable <= 0;
      mem_wenable <= 0;
      mem_addr <= 0;

      io_read_req <= 0;
      io_write_req <= 0;
      io_wdata <= 0;

      state <= s_init;
      pc <= 0;
      will_jump <= 0;
    end else begin
      case (state)

///////////////////////////////////////////////////
        s_init: begin
          if (boot) begin
            pc <= 0;
            state <= s_fetch;
          end
        end
///////////////////////////////////////////////////
        s_fetch: begin
          state <= s_decode;
          will_jump <= 0;
          use_imm <= 1'b0;
          reg_we <= 1'b0;
        end
///////////////////////////////////////////////////
        s_decode: begin
          state <= s_exec;
          // now inst_** are valid
          case (inst_op)
            `OP_li: begin
            end
            `OP_mr: begin
            end

            `OP_addi: begin
              use_imm <= 1'b1;
              imm <= simm16_32(inst_imm16);
              command <= `A_COM_add;
            end

            `OP_add: begin
              command <= `A_COM_add;
            end

            `OP_sub: begin
              command <= `A_COM_sub;
            end
            
            `OP_slwi: begin
              command <= `A_COM_sll;
              use_imm <= 1'b1;
              imm <= inst_rB;
            end

            `OP_srwi: begin
              command <= `A_COM_srl;
              use_imm <= 1'b1;
              imm <= inst_rB;
            end

            `OP_slw: begin
              command <= `A_COM_sll;
            end

            `OP_srw: begin
              command <= `A_COM_srl;
            end

            `OP_b: begin
              jump_pc <= pc + simm26_32(inst_imm26);
              will_jump <= 1'b1;
            end

            `OP_beq: begin
              jump_pc <= pc + simm26_32(inst_imm26);
              will_jump <= c0_eq;
            end

            `OP_bne: begin
              jump_pc <= pc + simm26_32(inst_imm26);
              will_jump <= ~c0_eq;
            end

            `OP_blt: begin
              jump_pc <= pc + simm26_32(inst_imm26);
              will_jump <= c0_lt;
            end

            `OP_bl: begin
              jump_pc <= pc + simm26_32(inst_imm26);
              will_jump <= 1'b1;
              linkreg <= pc + 1;
            end

            `OP_blr: begin
              jump_pc <= linkreg;
              will_jump <= 1'b1;
            end

            `OP_mflr: begin
            end
            `OP_mtlr: begin
              linkreg <= rD;
            end

            `OP_cmpwi: begin
              command <= `A_COM_sub;
              use_imm <= 1'b1;
              imm <= simm16_32(inst_imm16);
            end
            `OP_cmpw: begin
              command <= `A_COM_sub;
            end

            `OP_ld: begin
              mem_addr <= rA + simm16_32(inst_imm16);
              mem_enable <= 1'b1;
            end
            `OP_st: begin
              mem_addr <= rA + simm16_32(inst_imm16);
              mem_wdata <= rD;
              mem_enable <= 1'b1;
              mem_wenable <= 4'b1111;
            end

            `OP_out: begin
              io_wdata <= rD[7:0];
              state <= s_o;
            end
            `OP_in: begin
              state <= s_i;
            end

            default: begin
              err <= `ERR_C_INVALID_OP;
              state <= s_halt;
            end
          endcase
        end
///////////////////////////////////////////////////
        s_exec: begin
          case (inst_op)
            `OP_ld: begin
              mem_enable <= 1'b0;
            end
            `OP_st: begin
              mem_enable <= 1'b0;
              mem_wenable <= 1'b0;
            end
          endcase
          state <= s_write;
        end
///////////////////////////////////////////////////
        s_write: begin
          // now ALU output is valid
          // now bram rdata is valid
          if (will_jump) pc <= jump_pc;
          else pc <= pc + 32'd1;
          
          if (inst_op == `OP_li) begin
            reg_wdata <= simm16_32(inst_imm16);
            reg_we <= 1'b1;
          end
          if (inst_op == `OP_mr) begin
            reg_wdata <= rA;
            reg_we <= 1'b1;
          end
          if ((inst_op >= `OP_addi) && (inst_op <= `OP_srwi)) begin
            reg_wdata <= alu_out;
            reg_we <= 1'b1;
          end
          if (inst_op == `OP_mflr) begin
            reg_wdata <= linkreg;
            reg_we <= 1'b1;
          end
          if (inst_op == `OP_cmpwi) begin
            condreg <= {alu_out[31], ~(alu_out[31]), ~(|alu_out), 1'b0};
          end
          if (inst_op == `OP_cmpw) begin
            condreg <= {alu_out[31], ~(alu_out[31]), ~(|alu_out), 1'b0};
          end
          if (inst_op == `OP_ld) begin
            reg_wdata <= mem_rdata;
            reg_we <= 1'b1;
          end

          state <= s_fetch;
        end
///////////////////////////////////////////////////
        s_i: begin
          if (io_read_req) begin
            // requesting
            if (io_done) begin
              io_read_req <= 1'b0;
              reg_wdata <= {24'd0, io_rdata};
              reg_we <= 1'b1;
              pc <= pc + 1'b1;
              state <= s_fetch;
            end
          end else begin
            if (io_ready) io_read_req <= 1'b1;
          end
        end
        s_o: begin
          if (io_write_req) begin
            io_write_req <= 1'b0;
            pc <= pc + 1'b1;
            state <= s_fetch;
          end else begin
            if (io_ready) io_write_req <= 1'b1;
          end
        end
///////////////////////////////////////////////////
        s_halt: begin
          err <= err | `ERR_C_HALT;
          state <= state;
        end
        default: begin
          err <= `ERR_C_INVALID_STATE;
          state <= s_halt;
        end
      endcase
    end
  end
endmodule
