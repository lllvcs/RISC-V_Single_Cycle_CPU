`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 20:15:37
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU(
input               CLK,
input               RSTn,

output              RAW_block_o,
output              J_sig_o,

//PC
output[31:0]        PC_o,

//IR-DC
input[31:0]         INST,

//MEM-DR
output[31:0]        MEM2DR_addr,
output[31:0]        MEM2DR_dw,
output[3:0]         MEM2DR_wea,
input[31:0]         DR2WB_dr_reg,
input[31:0]         DR2WB_ior_reg,
input               DR2WB_io_sig_reg


//IO
//output[31:0]        IO_addr,
//output[31:0]        IO_dw,
//output[3:0]         IO_we,
//output              IO_rst,
//output              IO_en,
//input[31:0]         IO_dr
    );
wire RST;assign RST=~RSTn; 
//流水控制//
wire RAW_block,J_block;
wire EXE2IF_j_sig;//跳转标志位
wire[31:0] EXE2IF_j_PC;//跳转地址
assign RAW_block_o=RAW_block;
assign J_sig_o=EXE2IF_j_sig;
//流水控制//

//----------------------------------计算PC(PC)-----------------------------------------------
wire[31:0] PC;
wire[31:0] next_PC;

//计算新PC
PCC PCC(
    .PC(PC),
    .next_PC(next_PC),
    .EXE2IF_j_sig(EXE2IF_j_sig),
    .EXE2IF_j_PC(EXE2IF_j_PC)
);

//PC寄存器
REG_HE_PC#(.WIDTH(32))PCREG(.CLK(CLK),.RST(RST),.E(~EXE2IF_j_sig),.H(RAW_block),.in(next_PC),.out(PC));




//----------------------------------读指令(RI)----------------------------------------------
//RI-DC寄存器
wire[31:0] RI_PC;

//送出PC
assign PC_o=PC;

//除了读出指令外，还需要将上一级的PC锁存一拍
REG_HE_PC#(.WIDTH(32))RI2DC_PC(.CLK(CLK),.RST(RST),.E(~EXE2IF_j_sig),.H(RAW_block),.in(PC),.out(RI_PC));




//---------------------------------译码读寄存器(DC)-------------------------------------
//DC-REG交互信号
wire[4:0] DC2REG_idx0;//1、送入寄存器堆读取寄存器；2、送入相关判断模块判断相关性
wire[4:0] DC2REG_idx1;//1、送入寄存器堆读取寄存器；2、送入相关判断模块判断相关性
wire[31:0] REG2DC_data0;
wire[31:0] REG2DC_data1;
//DC生成的信号
wire[14:0] DC2EXE_info;//待定
wire[31:0] DC2EXE_OP0;
wire[31:0] DC2EXE_OP1;
wire[31:0] DC2EXE_PC;
wire[31:0] DC2EXE_PC_offset0;
wire[31:0] DC2EXE_PC_offset1;
wire[31:0] DC2EXE_store_data;
wire[4:0] DC2EXE_result_idx;//结果寄存器索引
//DC-EXE寄存器输出
wire[14:0] DC2EXE_info_reg;//待定
wire[31:0] DC2EXE_OP0_reg;
wire[31:0] DC2EXE_OP1_reg;
wire[31:0] DC2EXE_PC_reg;
wire[31:0] DC2EXE_PC_offset0_reg;
wire[31:0] DC2EXE_PC_offset1_reg;
wire[31:0] DC2EXE_store_data_reg;
wire[4:0] DC2EXE_result_idx_reg;//结果寄存器索引
//WB-REG
wire[31:0] WB2REG_wb_data;
wire[4:0] WB2REG_wb_idx;
wire WB2REG_wea;


//译码模块
DC DC(
    //IF-DC
    .INST(INST),
    .PC(RI_PC),   
    //DC-REG
    .DC2REG_idx0(DC2REG_idx0),
    .DC2REG_idx1(DC2REG_idx1),
    .REG2DC_data0(REG2DC_data0),
    .REG2DC_data1(REG2DC_data1),
    //DC-EXE    
    .DC2EXE_info(DC2EXE_info),//待定
    .DC2EXE_OP0(DC2EXE_OP0),
    .DC2EXE_OP1(DC2EXE_OP1),
    .DC2EXE_PC(DC2EXE_PC),
    .DC2EXE_PC_offset0(DC2EXE_PC_offset0),
    .DC2EXE_PC_offset1(DC2EXE_PC_offset1),
    .DC2EXE_store_data(DC2EXE_store_data),
    .DC2EXE_result_idx(DC2EXE_result_idx)//结果寄存器索引 
    
);
    
//寄存器堆
REG_FILE REG_FILE(
    .CLK(CLK),
    .RST(RST),
    //DC-REG
    .DC2REG_idx0(DC2REG_idx0),
    .DC2REG_idx1(DC2REG_idx1),
    .REG2DC_data0(REG2DC_data0),
    .REG2DC_data1(REG2DC_data1),   
    //WB-REG
    .WB2REG_result(WB2REG_wb_data),
    .WB2REG_result_idx(WB2REG_wb_idx),
    .WB2REG_wea(WB2REG_wea)
);

//DC-EXE寄存器
REG_HE#(.WIDTH(15))DC2EXE0(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_info),.out(DC2EXE_info_reg));
REG_HE#(.WIDTH(32))DC2EXE1(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_OP0),.out(DC2EXE_OP0_reg));
REG_HE#(.WIDTH(32))DC2EXE2(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_OP1),.out(DC2EXE_OP1_reg));
REG_HE#(.WIDTH(32))DC2EXE3(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_store_data),.out(DC2EXE_store_data_reg));
REG_HE#(.WIDTH(32))DC2EXE4(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_PC),.out(DC2EXE_PC_reg));
REG_HE#(.WIDTH(32))DC2EXE5(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_PC_offset0),.out(DC2EXE_PC_offset0_reg));
REG_HE#(.WIDTH(32))DC2EXE6(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_PC_offset1),.out(DC2EXE_PC_offset1_reg));
REG_HE#(.WIDTH(5))DC2EXE7(.CLK(CLK),.RST(RST),.E(~RAW_block),.H(1'b0),.in(DC2EXE_result_idx),.out(DC2EXE_result_idx_reg));




//---------------------------------------执行(EXE)----------------------------------------
//EXE生成的信号
wire[6:0] EXE2MEM_info;
wire[31:0] EXE2MEM_result;
wire[31:0] EXE2MEM_store_data;
wire[4:0] EXE2MEM_result_idx;
//EXE-MEM寄存器输出
wire[6:0] EXE2MEM_info_reg;
wire[31:0] EXE2MEM_result_reg;
wire[31:0] EXE2MEM_store_data_reg;
wire[4:0] EXE2MEM_result_idx_reg;


//执行模块
EXE EXE(
    //DC-EXE    
    .DC2EXE_info(DC2EXE_info_reg),//待定
    .DC2EXE_OP0(DC2EXE_OP0_reg),
    .DC2EXE_OP1(DC2EXE_OP1_reg),
    .DC2EXE_PC(DC2EXE_PC_reg),
    .DC2EXE_PC_offset0(DC2EXE_PC_offset0_reg),
    .DC2EXE_PC_offset1(DC2EXE_PC_offset1_reg),
    .DC2EXE_store_data(DC2EXE_store_data_reg),
    .DC2EXE_result_idx(DC2EXE_result_idx_reg),//结果寄存器索引 
    //EXE-MEM
    .EXE2MEM_info(EXE2MEM_info),//待定
    .EXE2MEM_result(EXE2MEM_result),
    .EXE2MEM_store_data(EXE2MEM_store_data),
    .EXE2MEM_result_idx(EXE2MEM_result_idx),
    //EXE-IF转移指令
    .EXE2IF_j_sig(EXE2IF_j_sig),
    .EXE2IF_j_PC(EXE2IF_j_PC)
);

//EXE-MEM寄存器
REG_HE#(.WIDTH(7))EXE2MEM0(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(EXE2MEM_info),.out(EXE2MEM_info_reg));
REG_HE#(.WIDTH(32))EXE2MEM1(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(EXE2MEM_result),.out(EXE2MEM_result_reg));
REG_HE#(.WIDTH(32))EXE2MEM2(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(EXE2MEM_store_data),.out(EXE2MEM_store_data_reg));
REG_HE#(.WIDTH(5))EXE2MEM3(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(EXE2MEM_result_idx),.out(EXE2MEM_result_idx_reg));





//------------------------------------访存(MEM)-----------------------------------------------------------
//MEM生成的信号
wire[2:0] MEM2WB_info;
wire[31:0] MEM2WB_result;
wire[4:0] MEM2WB_result_idx;
//MEM-WB寄存器输出(读存储器的结果导线在RI级定义)
//wire[31:0] MEM2WB_dr_reg;读内存结果，在RI级已经定义了
wire[2:0] MEM2WB_info_reg;
wire[31:0] MEM2WB_result_reg;
wire[4:0] MEM2WB_result_idx_reg;

//访存模块
MEM MEM(
    //EXE-MEM
    .EXE2MEM_info(EXE2MEM_info_reg),//待定
    .EXE2MEM_result(EXE2MEM_result_reg),
    .EXE2MEM_store_data(EXE2MEM_store_data_reg),
    .EXE2MEM_result_idx(EXE2MEM_result_idx_reg),    
    //读写存储器
    .MEM2DR_addr(MEM2DR_addr),
    .MEM2DR_dw(MEM2DR_dw),
    .MEM2DR_wea(MEM2DR_wea),
    //MEM-WB
    .MEM2WB_info(MEM2WB_info),
    .MEM2WB_result(MEM2WB_result),
    .MEM2WB_result_idx(MEM2WB_result_idx)
);
    
//EXE-WB寄存器
REG_HE#(.WIDTH(3))MEM2WB0(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(MEM2WB_info),.out(MEM2WB_info_reg));
REG_HE#(.WIDTH(32))MEM2WB1(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(MEM2WB_result),.out(MEM2WB_result_reg));
REG_HE#(.WIDTH(5))MEM2WB2(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(MEM2WB_result_idx),.out(MEM2WB_result_idx_reg));




//------------------------------------写回(WB)----------------------------------------------------------
//写回模块
WB WB(
    //MEM-WB
    .MEM2WB_info(MEM2WB_info_reg),//待定
    .MEM2WB_result(MEM2WB_result_reg),
    .DR2WB_dr(DR2WB_dr_reg),
    .DR2WB_ior(DR2WB_ior_reg),
    .DR2WB_io_sig(DR2WB_io_sig_reg),
    .MEM2WB_result_idx(MEM2WB_result_idx_reg),
    //WB-REG
    .WB2REG_wb_data(WB2REG_wb_data),
    .WB2REG_wb_idx(WB2REG_wb_idx),
    .WB2REG_wea(WB2REG_wea)
    );




//------------------------------------流水线控制-----------------------------------------------------
pipe_control pipe_control(
    .DC_OP0_idx(DC2REG_idx0),
    .DC_OP1_idx(DC2REG_idx1),

    .EXE_result_idx(DC2EXE_result_idx_reg),
    .MEM_result_idx(EXE2MEM_result_idx_reg),
    .WB_result_idx(MEM2WB_result_idx_reg),

    .DC_jtype(DC2EXE_info[14:11]),
    .EXE_jtype(DC2EXE_info_reg[14:11]),

    .RAW_block(RAW_block),
    .J_block(J_block)
    ); 
endmodule
