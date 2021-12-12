`timescale 1ns / 1ps

module pipe_control(
input[4:0]          DC_OP0_idx,//操作数0的寄存器号，要求：操作数0不来自于寄存器时，这个信号必须为0
input[4:0]          DC_OP1_idx,//操作数1的寄存器号，要求：操作数1不来自于寄存器时，这个信号必须为0

input[4:0]          EXE_result_idx,
input[4:0]          MEM_result_idx,
input[4:0]          WB_result_idx,

input[3:0]          DC_jtype,//DC2EXE_info,//{EXE跳转类型(14:11)
input[3:0]          EXE_jtype,//DC2EXE_info,EXE运算类型(10:7)

output              RAW_block,
output              J_block
    );
    
// PipeControl
wire EXE_flag, MEM_flag, WB_flag;
assign EXE_flag = (DC_OP0_idx & EXE_result_idx)|(DC_OP1_idx & EXE_result_idx)|(WB_result_idx & EXE_result_idx)|(EXE_result_idx & MEM_result_idx);
assign MEM_flag = (DC_OP0_idx & MEM_result_idx)|(DC_OP1_idx & MEM_result_idx)|(WB_result_idx & MEM_result_idx);
assign WB_flag = (DC_OP0_idx & WB_result_idx)|(DC_OP1_idx & WB_result_idx);
assign RAW_block = EXE_flag | MEM_flag | WB_flag;

endmodule
