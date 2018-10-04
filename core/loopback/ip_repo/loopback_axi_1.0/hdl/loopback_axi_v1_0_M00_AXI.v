
`timescale 1 ns / 1 ps

	module loopback_axi_v1_0_M00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// The master will start generating data from the C_M_START_DATA_VALUE value
		parameter  C_M_START_DATA_VALUE	= 32'h0,
		// The master requires a target slave base address.
    // The master will initiate read and write transactions on the slave with base address specified here as a parameter.
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h0,
		// Width of M_AXI address bus. 
    // The master generates the read and write addresses of width specified as C_M_AXI_ADDR_WIDTH.
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of M_AXI data bus. 
    // The master issues write data and accept read data where the width of the data bus is C_M_AXI_DATA_WIDTH
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		// Transaction number is the number of write 
    // and read transactions the master will perform as a part of this example memory test.
		parameter integer C_M_TRANSACTIONS_NUM	= 4
	)
	(
		// Users to add ports here
        input wire REG_AXI_SOFTRESET,
        input wire REG_AXI_START,

		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  INIT_AXI_TXN,
		// Asserts when ERROR is detected
		output reg  ERROR,
		// Asserts when AXI transactions is complete
		output wire  TXN_DONE,
		// AXI clock signal
		input wire  M_AXI_ACLK,
		// AXI active low reset signal
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address Channel ports. Write address (issued by master)
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Write channel Protection type.
    // This signal indicates the privilege and security level of the transaction,
    // and whether the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Write address valid. 
    // This signal indicates that the master signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data Channel ports. Write data (issued by master)
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. 
    // This signal indicates which byte lanes hold valid data.
    // There is one write strobe bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write valid. This signal indicates that valid write data and strobes are available.
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response Channel ports. 
    // This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Write response valid. 
    // This signal indicates that the channel is signaling a valid write response
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address Channel ports. Read address (issued by master)
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Protection type. 
    // This signal indicates the privilege and security level of the transaction, 
    // and whether the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Read address valid. 
    // This signal indicates that the channel is signaling valid read address and control information.
		output wire  M_AXI_ARVALID,
		// Read address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
		input wire  M_AXI_ARREADY,
		// Master Interface Read Data Channel ports. Read data (issued by slave)
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer.
		input wire [1 : 0] M_AXI_RRESP,
		// Read valid. This signal indicates that the channel is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can accept the read data and response information.
		output wire  M_AXI_RREADY
	);

    reg [C_M_AXI_ADDR_WIDTH-1 : 0] awaddr;
    assign M_AXI_AWADDR = awaddr;

    assign M_AXI_AWPROT = 3'b000;

    reg awvalid;
    assign M_AXI_AWVALID = awvalid;

    reg [C_M_AXI_DATA_WIDTH-1 : 0] wdata;
    assign M_AXI_WDATA = wdata;

    assign M_AXI_WSTRB = 4'b0000;

    reg wvalid;
    assign M_AXI_WVALID = wvalid;

    reg bready;
    assign M_AXI_BREADY = bready;

    reg [C_M_AXI_ADDR_WIDTH-1 : 0] araddr;
    assign M_AXI_ARADDR = araddr;

    assign M_AXI_ARPROT = 3'b000;

    reg arvalid;
    assign M_AXI_ARVALID = arvalid;

    reg rready;
    assign M_AXI_RREADY = rready;


    localparam IDLE   = 3'b000;
    localparam RXWAIT = 3'b001;
    localparam READ   = 3'b010;
    localparam TXWAIT = 3'b011;
    localparam WRITE  = 3'b100;
    reg [2:0] state;

    reg request_issued;
    always @(posedge M_AXI_ACLK) begin
        if ( (~M_AXI_ARESETN) || REG_AXI_SOFTRESET ) begin
            state <= IDLE;
            arvalid <= 1'b0;
            rready <= 1'b0;
            wvalid <= 1'b0;
            awvalid <= 1'b0;
            bready <= 1'b0;
            request_issued <= 1'b0;
        end else begin
            case (state)

            IDLE: begin
                if (REG_AXI_START) state <= RXWAIT;
            end

            RXWAIT: begin
                if (request_issued) begin
                    if (M_AXI_ARREADY && arvalid) begin
                        // request done
                        arvalid <= 1'b0;
                    end else if (rready) begin
                        // transaction done
                        rready <= 1'b0;
                        request_issued <= 1'b0;
                        if (M_AXI_RDATA[0]) begin
                            state <= READ;
                        end else begin
                            state <= RXWAIT;
                        end
                    end else if (M_AXI_RVALID) rready <= 1'b1;
                end else begin
                    // read request
                    arvalid <= 1'b1;
                    araddr <= 32'h8;
                    request_issued <= 1'b1;
                end
            end

            READ: begin
                if (request_issued) begin
                    if (M_AXI_ARREADY && arvalid) begin
                        // request done
                        arvalid <= 1'b0;
                    end else if (rready) begin
                        // transaction done
                        rready <= 1'b0;
                        request_issued <= 1'b0;

                        wdata[7:0] <= M_AXI_RDATA[7:0];
                        state <= TXWAIT;
                    end else if (M_AXI_RVALID) rready <= 1'b1;
                end else begin
                    // read request
                    arvalid <= 1'b1;
                    araddr <= 32'h0;
                    request_issued <= 1'b1;
                end
            end

            TXWAIT: begin
                if (request_issued) begin
                    if (M_AXI_ARREADY && arvalid) begin
                        // request done
                        arvalid <= 1'b0;
                    end else if (rready) begin
                        // transaction done
                        rready <= 1'b0;
                        request_issued <= 1'b0;

                        if (~M_AXI_RDATA[3]) state <= WRITE; // if not full
                        else state <= TXWAIT;
                    end else if (M_AXI_RVALID) rready <= 1'b1;
                end else begin
                    // read request
                    arvalid <= 1'b1;
                    araddr <= 32'h8;
                    request_issued <= 1'b1;
                end
            end

            WRITE: begin
                if (request_issued) begin
                    if (M_AXI_WREADY && wvalid) wvalid <= 1'b0;
                    if (M_AXI_AWREADY && awvalid) awvalid <= 1'b0;
                    if (bready) begin
                        bready <= 1'b0;
                        request_issued <= 1'b0;
                        state <= RXWAIT;
                    end else if (M_AXI_BVALID) bready <= 1'b1;
                end else begin
                    // send request
                    wvalid <= 1'b1;
                    awvalid <= 1'b1;
                    awaddr <= 32'h4;
                    wdata <= wdata;
                end
            end

            default: begin
                state <= IDLE;
            end

            endcase
        end
    end
	endmodule
