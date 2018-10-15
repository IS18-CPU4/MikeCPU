module MemoryReader(
  input wire next_btn,
  input wire prev_btn,
  input wire msb_btn,
  input wire lsb_btn,
  output wire bram_en,
  output wire [31:0] bram_addr,
  input wire CLK,
  input wire RSTN
);
  reg [31:0] addr;
  reg [2:0]  bits;
  reg next_btn_buf;
  reg prev_btn_buf;
  reg msb_btn_buf;
  reg lsb_btn_buf;

  assign bram_en = 1'b1;
  assign bram_addr = addr;

  always @(posedge CLK) begin
    if (~RSTN) begin
      data <= 8'd0;
      addr <= 32'd0;
      bits <= 3'd0;
      next_btn_buf <= 1'b0;
      prev_btn_buf <= 1'b0;
      msb_btn_buf <= 1'b0;
      lsb_btn_buf <= 1'b0;
    end else begin
      next_btn_buf <= next_btn;
      prev_btn_buf <= prev_btn;
      msb_btn_buf <= msb_btn;
      lsb_btn_buf <= lsb_btn;

      if (next_btn & ~next_btn_buf) addr <= addr + 1'b1;
      if (prev_btn & ~prev_btn_buf) addr <= addr - 1'b1;
      if (msb_btn & ~msb_btn_buf) addr <= bits + 1'b1;
      if (lsb_btn & ~lsb_btn_buf) addr <= bits - 1'b1;
      
