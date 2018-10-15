`default_nettype none

`define B_ERR_InvalidFormat 8'd1
`define B_ERR_RunOverIterator 8'd2

module Bootloader(
  // for memory
  output wire [31:0] BRAM_ADDR,
  output wire [31:0] BRAM_WRDATA,
  output wire [3:0]  BRAM_WE,
  output wire        BRAM_EN,

  // for axi_uart
  output wire [31:0] M01_AXI_AWADDR,
  output wire [2:0]  M01_AXI_AWPROT,
  output wire        M01_AXI_AWVALID,
  input wire         M01_AXI_AWREADY,
  output wire [31:0] M01_AXI_WDATA,
  output wire [3:0]  M01_AXI_WSTRB,
  output wire        M01_AXI_WVALID,
  input wire         M01_AXI_WREADY,
  input wire [1:0]   M01_AXI_BRESP,
  input wire         M01_AXI_BVALID,
  output wire        M01_AXI_BREADY,
  output wire [31:0] M01_AXI_ARADDR,
  output wire [2:0]  M01_AXI_ARPROT,
  output wire        M01_AXI_ARVALID,
  input wire         M01_AXI_ARREADY,
  input wire [31:0]  M01_AXI_RDATA,
  input wire [1:0]   M01_AXI_RRESP,
  input wire         M01_AXI_RVALID,
  output wire        M01_AXI_RREADY,

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
  
  // for axi_uart
  reg ext_request_issued;
  reg ext_arvalid;
  reg ext_rready;
  reg [31:0] ext_araddr;
  assign M01_AXI_ARVALID = ext_arvalid;
  assign M01_AXI_RREADY  = ext_rready;
  assign M01_AXI_ARADDR  = ext_araddr;
  assign M01_AXI_ARPROT  = 3'b000;

  assign M01_AXI_AWADDR  = 0;
  assign M01_AXI_AWPROT  = 0;
  assign M01_AXI_AWVALID = 0;
  assign M01_AXI_WDATA   = 0;
  assign M01_AXI_WSTRB   = 0;
  assign M01_AXI_WVALID  = 0;
  assign M01_AXI_BREADY  = 0;

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
      ext_request_issued <= 1'b0;
      ext_arvalid <= 1'b0;
      ext_rready <= 1'b0;
      ext_araddr <= 32'd0;
      data_iterator <= 32'd0;
      data_length <= 32'd0;
      length_iterator <= 3'd0;
      err <= 8'd0;
    end else begin
      case (state)
        s_init: state <= s_ext_chkRx;
        s_ext_chkRx: begin
          if (ext_request_issued) begin
            if (M01_AXI_ARREADY & ext_arvalid) ext_arvalid <= 1'b0;
            if (M01_AXI_RVALID & (~ext_rready)) ext_rready <= 1'b1;
            if (ext_rready) begin
              ext_rready <= 1'b0;
              ext_request_issued <= 1'b0;
              // state move
              if (M01_AXI_RDATA[0]) begin
                state <= s_ext_read;
              end else begin
                state <= s_ext_chkRx;
              end
            end
          end else begin
            ext_arvalid <= 1'b1;
            ext_araddr <= 32'h8;
            ext_request_issued <= 1'b1;
          end
        end

        s_ext_read: begin
          if (ext_request_issued) begin
            if (M01_AXI_ARREADY & ext_arvalid) ext_arvalid <= 1'b0;
            if (M01_AXI_RVALID & (~ext_rready)) ext_rready <= 1'b1;
            if (ext_rready) begin
              ext_rready <= 1'b0;
              ext_request_issued <= 1'b0;
              // state move
              if (length_iterator < 3'd2) begin
                data_length <= {data_length[23:0], M01_AXI_RDATA[7:0]};
                state <= s_ext_chkRx;
                length_iterator <= length_iterator + 3'b1;
              end else if (data_iterator < data_length) begin
                mem_addr <= {2'b00, data_iterator[31:2]};
                mem_enable <= 1'b1;
                if (data_step == 2'd0) begin
                  mem_wdata[31:24] <= M01_AXI_RDATA[7:0];
                  mem_wenable <= 4'b1000;
                end
                if (data_step == 2'd1) begin
                  mem_wdata[23:16] <= M01_AXI_RDATA[7:0];
                  mem_wenable <= 4'b0100;
                end
                if (data_step == 2'd2) begin
                  mem_wdata[15:8] <= M01_AXI_RDATA[7:0];
                  mem_wenable <= 4'b0010;
                end
                if (data_step == 2'd3) begin
                  mem_wdata[7:0] <= M01_AXI_RDATA[7:0];
                  mem_wenable <= 4'b0001;
                end
                state <= s_mem_write;
                data_iterator <= data_iterator + 32'd1;
              end else begin
                err <= `B_ERR_RunOverIterator;
                state <= s_halt;
              end
            end
          end else begin
            ext_arvalid <= 1'b1;
            ext_araddr <= 32'h0;
            ext_request_issued <= 1'b1;
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
