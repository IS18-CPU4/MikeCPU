module Processor(
  // for inst memory
  output wire [31:0] inst_addr,
  output wire [31:0] inst_wdata,
  input wire [31:0]  inst_rdata,
  output wire [3:0]  inst_we,
  output wire        inst_en,

  // for RAM
  input wire [31:0] mem_rdata,
  output wire [31:0] mem_wdata,
  output wire [31:0] mem_addr,
  output wire [3:0] mem_wenable,
  output wire mem_enable,

  // for IO
  output wire io_read_req,
  output wire io_write_req,
  input wire io_ready,
  input wire io_done,
  output wire [7:0] io_wdata,
  input wire [7:0] io_rdata,

  output wire boot_ready,
  output wire [7:0] err,
  input wire CLK,
  input wire RSTN
);

  wire [31:0] cont_inst_addr;
  wire cont_inst_enable;
  wire cont_io_read_req, cont_io_write_req;
  wire [7:0] cont_io_wdata;
  wire [7:0] cont_err;

  wire [31:0] boot_inst_addr;
  wire boot_inst_enable;
  wire boot_io_read_req;
  wire [7:0] boot_err;

  wire boot;
  assign boot_ready = boot;
  assign inst_addr = boot ? cont_inst_addr : boot_inst_addr;
  assign inst_en   = boot ? cont_inst_enable : boot_inst_enable;
  assign io_read_req = boot ? cont_io_read_req : boot_io_read_req;
  assign io_write_req = boot ? cont_io_write_req : 1'b0;
  assign io_wdata = boot ? cont_io_wdata : 8'd0;

  assign err = {cont_err[3:0], boot_err[3:0]};

  Controller cont(
    mem_rdata, mem_wdata, mem_addr, mem_wenable, mem_enable,
    inst_rdata, cont_inst_addr, cont_inst_enable,
    cont_io_read_req, cont_io_write_req, io_ready, io_done, cont_io_wdata, io_rdata,
    boot, cont_err, CLK, RSTN);

  Bootloader_IO bootloader(
    boot_inst_addr, inst_wdata, inst_we, boot_inst_enable,
    boot_io_read_req, io_ready, io_done, io_rdata,
    boot, boot_err, CLK, RSTN);

endmodule
