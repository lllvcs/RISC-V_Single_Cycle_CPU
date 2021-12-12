`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//写回类型：
//0不写回，1运算结果写回，2访存32位结果写回，3访存16位符号扩展
//4访存16位高位补0，5访存8位符号扩展，6访存8位高位补0，7访io32位结果写回
//////////////////////////////////////////////////////////////////////////////////


module WB(
//MEM-WB
input[2:0]         MEM2WB_info,//{写回类型(2:0)}
input[31:0]        DR2WB_dr,//从内存中读的值
input[31:0]        DR2WB_ior,//从内存中读出的值
input              DR2WB_io_sig,//这个信号为1，说明读的是IO段（地址大于0x80000000）而不是数据段，读出的值由DR2WB_ior给出
input[31:0]        MEM2WB_result,//EXE运算结果
input[4:0]         MEM2WB_result_idx,//目的寄存器号

//WB-REG
output  [31:0]       WB2REG_wb_data,//写回的数据
output  [4:0]        WB2REG_wb_idx,//目的寄存器索引
output             WB2REG_wea//写使能

    );

//写回类型 WB2REG_wea
assign WB2REG_wea = (!(MEM2WB_info == 3'b0));

//DR2WB_io_sig
wire [31:0] DR2WBTemp;
MUX2#(.WIDTH(32))DR2WB(
.D0(DR2WB_dr),.D1(DR2WB_ior),.A(DR2WB_io_sig),.Y(DR2WBTemp)
);
//WB2REG_wb_data
MUX8#(.WIDTH(32))WBData(
//.D0(MEM2WB_result),.D1(DR2WBTemp),.D2(1'b0),.D3(1'b0),.D4(1'b0),.D5(1'b0),.D6(1'b0),.A(MEM2WB_info),.Y(WB2REG_wb_data)
.D0({32'b0} ),.D1(MEM2WB_result ),.D2(DR2WBTemp ),.D3( {{16{DR2WBTemp[15]}},DR2WBTemp[15:0]}),.D4({{16'b0},DR2WBTemp[15:0]} ),
.D5({{24{DR2WBTemp[15]}},DR2WBTemp[7:0]} ),.D6({{8'b0},DR2WBTemp[7:0]} ),.D7(DR2WBTemp),.A(MEM2WB_info),.Y(WB2REG_wb_data)
);

assign  WB2REG_wb_idx = MEM2WB_result_idx;

endmodule