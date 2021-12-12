// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "CPU,Vivado 2017.4" *)
module TOP_CPU_0_0(CLK, RSTn, RAW_block_o, J_sig_o, PC_o, INST, 
  MEM2DR_addr, MEM2DR_dw, MEM2DR_wea, DR2WB_dr_reg, DR2WB_ior_reg, DR2WB_io_sig_reg);
  input CLK;
  input RSTn;
  output RAW_block_o;
  output J_sig_o;
  output [31:0]PC_o;
  input [31:0]INST;
  output [31:0]MEM2DR_addr;
  output [31:0]MEM2DR_dw;
  output [3:0]MEM2DR_wea;
  input [31:0]DR2WB_dr_reg;
  input [31:0]DR2WB_ior_reg;
  input DR2WB_io_sig_reg;
endmodule
