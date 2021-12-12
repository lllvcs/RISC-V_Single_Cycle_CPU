// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "mem_control,Vivado 2017.4" *)
module TOP_mem_control_0_0(CLK, RSTn, RAW_block, J_sig, PC, INST, addra, dwa, dra, 
  ena, wea, MEM2DR_addr, MEM2DR_dw, MEM2DR_wea, DR2WB_dr_reg, DR2WB_ior_reg, DR2WB_io_sig_reg, 
  addrb, dwb, drb, enb, web, addrio, dwio, drio, enio, weio, rstio);
  input CLK;
  input RSTn;
  input RAW_block;
  input J_sig;
  input [31:0]PC;
  output [31:0]INST;
  output [31:0]addra;
  output [31:0]dwa;
  input [31:0]dra;
  output ena;
  output [3:0]wea;
  input [31:0]MEM2DR_addr;
  input [31:0]MEM2DR_dw;
  input [3:0]MEM2DR_wea;
  output [31:0]DR2WB_dr_reg;
  output [31:0]DR2WB_ior_reg;
  output DR2WB_io_sig_reg;
  output [31:0]addrb;
  output [31:0]dwb;
  input [31:0]drb;
  output enb;
  output [3:0]web;
  output [31:0]addrio;
  output [31:0]dwio;
  input [31:0]drio;
  output enio;
  output [3:0]weio;
  output rstio;
endmodule
