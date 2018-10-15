`default_nettype none

`define B_ERR_InvalidFormat 8'd1
`define B_ERR_RunOverIterator 8'd2

module Bootloader_IO(
  // for memory
  output wire [31:0] BRAM_ADDR,
  output wire [31:0] BRAM_WRDATA,
  output wire [3:0]  BRAM_WE,
  output wire        BRAM_EN,

  // for IO
  output reg io_read_req,
  input wire io_ready,
  input wire io_done,
  input wire [7:0] io_rdata,

  output wire boot_ready,
  output reg [7:0] err,
  input wire CLK,
  input wire RSTN
);

  localparam s_init      = 3'b000;
  localparam s_ext_chkRx = 3'b001;
  localparam s_ext_read  = 3'b010;
  localparam s_mem_write = 3'b011;
  localparam s_run       = 3'b100;
  localparam s_halt      = 3'b101;

  reg [2:0] state;
  assign boot_ready = (state == s_run) ? 1'b1 : 1'b0;
  // for memory
  reg [31:0] mem_addr;
  reg [31:0] mem_wdata;
  reg [3:0] mem_wenable;
  reg mem_enable;
  assign BRAM_ADDR = mem_addr;
  assign BRAM_WRDATA = mem_wdata;
  assign BRAM_WE = mem_wenable;
  assign BRAM_EN = mem_enable;
  

  // format
  // you can read 1 byte in 1 axi-uart iteration
  reg [2:0] length_iterator; // length 2byte (16bit) counter.
  reg [31:0] data_iterator;  // data counter. 
  reg [31:0] data_length;
  wire [1:0] data_step;
  assign data_step = data_iterator[1:0];

  // task
  always @(posedge CLK) begin
    if (~RSTN) begin
      state <= s_init;
      mem_wdata <= 32'd0;
      mem_addr <= 32'd0;
      mem_enable <= 1'b0;
      mem_wenable <= 4'b0000;

      io_read_req <= 1'b0;

      data_iterator <= 32'd0;
      data_length <= 32'd0;
      length_iterator <= 3'd0;
      err <= 8'd0;
    end else begin
      case (state)
        s_init: state <= s_ext_chkRx;
        s_ext_chkRx: begin
          if (io_ready) begin
            io_read_req <= 1'b1;
            state <= s_ext_read;
          end
        end

        s_ext_read: begin
          if (io_read_req) io_read_req <= 1'b0;
          if (io_done) begin
            // state move
            if (length_iterator < 3'd2) begin
              data_length <= {data_length[23:0], io_rdata[7:0]};
              state <= s_ext_chkRx;
              length_iterator <= length_iterator + 3'b1;
            end else if (data_iterator < data_length) begin
              mem_addr <= {data_iterator[31:2], 2'b00};
              mem_enable <= 1'b1;
              if (data_step == 2'd0) begin
                mem_wdata[31:24] <= io_rdata[7:0];
                mem_wenable <= 4'b1000;
              end
              if (data_step == 2'd1) begin
                mem_wdata[23:16] <= io_rdata[7:0];
                mem_wenable <= 4'b0100;
              end
              if (data_step == 2'd2) begin
                mem_wdata[15:8] <= io_rdata[7:0];
                mem_wenable <= 4'b0010;
              end
              if (data_step == 2'd3) begin
                mem_wdata[7:0] <= io_rdata[7:0];
                mem_wenable <= 4'b0001;
              end
              state <= s_mem_write;
              data_iterator <= data_iterator + 32'd1;
            end else begin
              err <= `B_ERR_RunOverIterator;
              state <= s_halt;
            end
          end
        end

        s_mem_write: begin
          mem_enable <= 1'b0;
          mem_wenable <= 4'b0000;
          if (data_iterator == data_length) begin
            // EOF, start booting
            state <= s_run;
          end else begin
            state <= s_ext_chkRx;
          end
        end

        default: begin
          state <= state;
        end
      endcase
    end
  end
endmodule
