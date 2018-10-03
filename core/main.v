`define C_ST_fetch   2'b00
`define C_ST_decode  2'b01
`define C_ST_exec    2'b10
`define C_ST_write   2'b11

`define OP_li       6'd0
`define OP_mr       6'd1
`define OP_addi     6'd2
`define OP_add      6'd3
`define OP_sub      6'd4

`define OP_b        6'd14

`define OP_out      6'd29

`define r0  5'd0
`define r1  5'd1
`define r2  5'd2
`define r3  5'd3
`define r4  5'd4
`define r5  5'd5
`define r6  5'd6
`define r7  5'd7
`define r8  5'd8
`define r9  5'd9
`define r10 5'd10

`define COM_li(rD, simm16)       {OP_li,   rD,   5'd0, simm16}
`define COM_mr(rD, rA)           {OP_mr,   rD,   rA,   16'd0 }
`define COM_addi(rD, rA, simm16) {OP_addi, rD,   rA,   simm16}
`define COM_add(rD, rA, rB)      {OP_add,  rD,   rA,   16'd0 }
`define COM_sub(rD, rA, rB)      {OP_sub,  rD,   rA,   16'd0 }

`define COM_b(simm26)            {OP_b,    simm26            }

`define COM_out(rA)              {OP_out,  rA,   5'd0, 16'd0 }

`define A_COM_add 4'd1
`define A_COM_sub 4'd2

function [0:31] romdata;
  input [0:31] address;

  case (address)
  32'd0: romdata = `COM_mr(`r1, `r0);
  32'd1: romdata = `COM_addi(`r1, `r1, 16'd1);
  32'd2: romdata = `COM_mr(`r2, `r0);
  32'd3: romdata = `COM_mr(`r3, `r0);

  32'd4: romdata = `COM_out(`r1);
  32'd5: romdata = `COM_mr(`r3, `r2);
  32'd6: romdata = `COM_mr(`r2, `r1);
  32'd7: romdata = `COM_add(`r1, `r2, `r3);
  32'd8: romdata = `COM_b(26'b11_111111_111111_111111_111100);
  default: romdata = 32'h0;
  endcase
endfunction

function alu(
  input wire [0:31] rA,
  input wire [0:31] rB,
  input wire [0:3] command,
  output wire [0:31] rD
);
  assign rD = (command == `A_COM_add) ? rA + rB
            : (command == `A_COM_sub) ? rA - rB
            : 32'd0;
endmodule

module controller(
  input wire CLK,
  input wire RST
);
  reg [0:31] pc;
  reg [0:31] register [0:3];
  reg [0:1] state;

  reg [0:31] inst;
  wire [0:5] inst_op;
  wire [0:4] inst_rD;
  wire [0:4] inst_rA;
  wire [0:4] inst_rB;
  wire [0:4] inst_imm5;
  wire [0:15] inst_imm16;
  wire [0:25] inst_imm26;
  assign {inst_op, inst_rD, inst_rA, inst_rB} = inst[0:20];
  assign inst_imm5 = inst[16:20];
  assign inst_imm16 = inst[16:31];
  assign inst_imm26 = inst[6:31];


  reg [0:31] rA;
  reg [0:31] rB;
  wire [0:31] rD;
  reg [0:3] command;
  alu int_alu(rA, rB, command, rD);
  reg [0:4] save_reg;

  always @(posedge CLK) begin
    if (RST) begin
      pc <= 32'd0;
      state <= `C_ST_fetch;
    end else begin
      case (state)

      `C_ST_fetch: begin
        inst <= romdata(pc);
        state <= `C_ST_decode;
      end

      `C_ST_decode: begin
        case (inst_op)
        `OP_li: begin
          rA <= 32'd0;
          rB <= inst_imm16[0] ? {16'hFFFF, inst_imm16} : {16'h0, inst_imm16};
          command <= `A_COM_add;
          save_reg <= inst_rD;
        end
        `OP_add: begin
          rA <= register[inst_rA];
          rB <= register[inst_rB];
          command <= `A_COM_add;
          save_reg <= inst_rD;
        end
        `OP_addi: begin
          rA <= register[inst_rA];
          rB <= inst_imm16[0] ? {16'hFFFF, inst_imm16} : {16'h0, inst_imm16};
          command <= `A_COM_add;
          save_reg <= inst_rD;
        end
        `OP_mr: begin
          rA <= register[inst_rA];
          rB <= 32'd0;
          command <= `A_COM_add;
          save_reg <= inst_rD;
        end
        `OP_b: begin
          rA <= pc;
          rB <= inst_imm26[0] ? {6'b111111, inst_imm26} : {6'h0, inst_imm26};
          save_reg <= 5'd0;
        end
        endcase
        state <= `C_ST_exec;
      end


      `C_ST_exec: begin
        register[save_reg] <= rD;
        state <= `C_ST_write;
      end


      `C_ST_write: begin
        if (inst_op == `OP_b) pc <= rD;
        else pc <= pc + 32'd1;

        state <= `C_ST_fetch;
      end
      endcase
    end

  end