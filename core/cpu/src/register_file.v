module RegisterFile (
    input wire [4:0] addr0,
    input wire [4:0] addr1,
    input wire [4:0] addr2,
    output wire [31:0] dout0,
    output wire [31:0] dout1,
    output wire [31:0] dout2,
    input wire we,
    input wire [31:0] wdata,
    input wire CLK);

    reg [31:0] RF [0:31];
    assign dout0 = (addr0 == 0) ? 32'd0 : RF[addr0];
    assign dout1 = (addr1 == 0) ? 32'd0 : RF[addr1];
    assign dout2 = (addr2 == 0) ? 32'd0 : RF[addr2];
    always @(posedge CLK) begin
        if (we) RF[addr0] <= wdata;
    end
endmodule
