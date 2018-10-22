module IObuf(
  input wire io_read_req,
  input wire io_write_req,
  output reg io_ready,
  output reg io_done,
  input wire [7:0] din,
  output reg [7:0] dout,


  // for axi_uart
  output wire [31:0] M_AXI_AWADDR,
  output wire [2:0]  M_AXI_AWPROT,
  output wire        M_AXI_AWVALID,
  input wire         M_AXI_AWREADY,
  output wire [31:0] M_AXI_WDATA,
  output wire [3:0]  M_AXI_WSTRB,
  output wire        M_AXI_WVALID,
  input wire         M_AXI_WREADY,
  input wire [1:0]   M_AXI_BRESP,
  input wire         M_AXI_BVALID,
  output wire        M_AXI_BREADY,
  output wire [31:0] M_AXI_ARADDR,
  output wire [2:0]  M_AXI_ARPROT,
  output wire        M_AXI_ARVALID,
  input wire         M_AXI_ARREADY,
  input wire [31:0]  M_AXI_RDATA,
  input wire [1:0]   M_AXI_RRESP,
  input wire         M_AXI_RVALID,
  output wire        M_AXI_RREADY,

  input wire CLK,
  input wire RSTN
);
  localparam [2:0] s_init =  3'b000;
  localparam [2:0] s_idle =  3'b001;
  localparam [2:0] s_chkRx = 3'b010;
  localparam [2:0] s_read =  3'b011;
  localparam [2:0] s_chkTx = 3'b100;
  localparam [2:0] s_write = 3'b101;
  reg [2:0] state;
  reg request_issued;

  reg [7:0] req_data;


  // for axi_uart
  reg ext_request_issued;
  reg ext_arvalid;
  reg ext_rready;
  reg [31:0] ext_awaddr;
  reg ext_awvalid;
  reg [31:0] ext_wdata;
  reg ext_wvalid;
  reg ext_bready;
  reg [31:0] ext_araddr;
  assign M_AXI_ARVALID = ext_arvalid;
  assign M_AXI_RREADY  = ext_rready;
  assign M_AXI_ARADDR  = ext_araddr;
  assign M_AXI_ARPROT  = 3'b000;

  assign M_AXI_AWADDR  = ext_awaddr;
  assign M_AXI_AWPROT  = 3'b000;
  assign M_AXI_AWVALID = ext_awvalid;
  assign M_AXI_WDATA   = ext_wdata;
  assign M_AXI_WSTRB   = 4'b1111;
  assign M_AXI_WVALID  = ext_wvalid;
  assign M_AXI_BREADY  = ext_bready;

  always @(posedge CLK) begin
    if (~RSTN) begin
      io_done <= 0;
      io_ready <= 0;
      dout <= 0;
      state <= s_init;
      req_data <= 0;
      request_issued <= 0;
    end else begin
      case (state)
        s_init: begin
          io_ready <= 1'b1;
          io_done <= 1'b0;
          state <= s_idle;
        end
        s_idle: begin
          if (io_read_req) begin
            io_ready <= 0;
            state <= s_chkRx;
          end else if (io_write_req) begin
            io_ready <= 0;
            state <= s_chkTx;
            req_data <= din;
          end
        end
        s_chkRx: begin
          if (request_issued) begin
            if (M_AXI_ARREADY & ext_arvalid) ext_arvalid <= 1'b0;
            if (M_AXI_RVALID & (~ext_rready)) ext_rready <= 1'b1;
            if (ext_rready) begin
              ext_rready <= 1'b0;
              request_issued <= 1'b0;
              if (M_AXI_RDATA[0]) begin
                state <= s_read;
              end else begin
                state <= state;
              end
            end
          end else begin
            ext_arvalid <= 1'b1;
            ext_araddr <= 32'h8;
            request_issued <= 1'b1;
          end
        end
        s_read: begin
          if (request_issued) begin
            if (M_AXI_ARREADY & ext_arvalid) ext_arvalid <= 1'b0;
            if (M_AXI_RVALID & (~ext_rready)) ext_rready <= 1'b1;
            if (ext_rready) begin
              ext_rready <= 1'b0;
              request_issued <= 1'b0;
              io_done <= 1'b1;
              dout <= M_AXI_RDATA[7:0];
              state <= s_init;
            end
          end else begin
            ext_arvalid <= 1'b1;
            ext_araddr <= 32'h0;
            request_issued <= 1'b1;
          end
        end
        s_chkTx: begin
          if (request_issued) begin
            if (M_AXI_ARREADY & ext_arvalid) ext_arvalid <= 1'b0;
            if (M_AXI_RVALID & (~ext_rready)) ext_rready <= 1'b1;
            if (ext_rready) begin
              ext_rready <= 1'b0;
              request_issued <= 1'b0;
              if (~M_AXI_RDATA[3]) state <= s_write;
              else state <= state;
            end
          end else begin
            ext_arvalid <= 1'b1;
            ext_araddr <= 32'h8;
            request_issued <= 1'b1;
          end
        end
        s_write: begin
          if (request_issued) begin
            if (M_AXI_WREADY & ext_wvalid) ext_wvalid <= 1'b0;
            if (M_AXI_AWREADY & ext_awvalid) ext_awvalid <= 1'b0;
            if (ext_bready) begin
              ext_bready <= 1'b0;
              request_issued <= 1'b0;
              io_done <= 1'b1;
              state <= s_init;
            end else if (M_AXI_BVALID) ext_bready <= 1'b1;
          end else begin
            ext_wvalid <= 1'b1;
            ext_awvalid <= 1'b1;
            ext_awaddr <= 32'h4;
            request_issued <= 1'b1;
            ext_wdata <= req_data;
          end
        end
        default: begin end
      endcase
    end
  end
endmodule
