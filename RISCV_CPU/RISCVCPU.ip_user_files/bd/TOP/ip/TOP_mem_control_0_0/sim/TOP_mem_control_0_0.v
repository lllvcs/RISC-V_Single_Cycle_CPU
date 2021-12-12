// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:mem_control:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module TOP_mem_control_0_0 (
  CLK,
  RSTn,
  RAW_block,
  J_sig,
  PC,
  INST,
  addra,
  dwa,
  dra,
  ena,
  wea,
  MEM2DR_addr,
  MEM2DR_dw,
  MEM2DR_wea,
  DR2WB_dr_reg,
  DR2WB_ior_reg,
  DR2WB_io_sig_reg,
  addrb,
  dwb,
  drb,
  enb,
  web,
  addrio,
  dwio,
  drio,
  enio,
  weio,
  rstio
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RSTn, FREQ_HZ 1000000, PHASE 0.000, CLK_DOMAIN TOP_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
input wire CLK;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RSTn, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RSTn RST" *)
input wire RSTn;
input wire RAW_block;
input wire J_sig;
input wire [31 : 0] PC;
output wire [31 : 0] INST;
output wire [31 : 0] addra;
output wire [31 : 0] dwa;
input wire [31 : 0] dra;
output wire ena;
output wire [3 : 0] wea;
input wire [31 : 0] MEM2DR_addr;
input wire [31 : 0] MEM2DR_dw;
input wire [3 : 0] MEM2DR_wea;
output wire [31 : 0] DR2WB_dr_reg;
output wire [31 : 0] DR2WB_ior_reg;
output wire DR2WB_io_sig_reg;
output wire [31 : 0] addrb;
output wire [31 : 0] dwb;
input wire [31 : 0] drb;
output wire enb;
output wire [3 : 0] web;
output wire [31 : 0] addrio;
output wire [31 : 0] dwio;
input wire [31 : 0] drio;
output wire enio;
output wire [3 : 0] weio;
output wire rstio;

  mem_control inst (
    .CLK(CLK),
    .RSTn(RSTn),
    .RAW_block(RAW_block),
    .J_sig(J_sig),
    .PC(PC),
    .INST(INST),
    .addra(addra),
    .dwa(dwa),
    .dra(dra),
    .ena(ena),
    .wea(wea),
    .MEM2DR_addr(MEM2DR_addr),
    .MEM2DR_dw(MEM2DR_dw),
    .MEM2DR_wea(MEM2DR_wea),
    .DR2WB_dr_reg(DR2WB_dr_reg),
    .DR2WB_ior_reg(DR2WB_ior_reg),
    .DR2WB_io_sig_reg(DR2WB_io_sig_reg),
    .addrb(addrb),
    .dwb(dwb),
    .drb(drb),
    .enb(enb),
    .web(web),
    .addrio(addrio),
    .dwio(dwio),
    .drio(drio),
    .enio(enio),
    .weio(weio),
    .rstio(rstio)
  );
endmodule
