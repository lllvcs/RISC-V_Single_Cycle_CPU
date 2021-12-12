`timescale 1ns / 1ps

module MEM(
//EXE-MEM
input [6:0]          EXE2MEM_info,//{MEM存储器写使能(6:3),写回类型(2:0)}
input [31:0]         EXE2MEM_result,//不用修改直接传递
input [4:0]          EXE2MEM_result_idx,//不用修改直接传递
input [31:0]         EXE2MEM_store_data,//把这个存到memory里

//读写存储器
//读存储器的结果直接从存储器送到WB模块，不经过MEM
output [31:0]        MEM2DR_addr,//访存地址，如果是访存指令，那么EXE2MEM_result就是访存地址
output [31:0]        MEM2DR_dw,//要存到memory里的数
output [3:0]         MEM2DR_wea,//写使能，EXE2MEM_info里已经给了，如果不是store指令，这个字段肯定是全0

//MEM-WB
output [2:0]         MEM2WB_info,//{写回类型(2:0)}
output [31:0]        MEM2WB_result,
output [31:0]        MEM2WB_result_idx
    );
//assign MEM2DR_wea = EXE2MEM_info[6:3];
assign MEM2WB_info = EXE2MEM_info[2:0];
assign MEM2DR_dw = EXE2MEM_store_data;
assign MEM2WB_result = EXE2MEM_result ;
assign MEM2WB_result_idx = EXE2MEM_result_idx;

//MEM2DR_addr
MUX2#(.WIDTH(32))MUX2_reg2(
.D0(EXE2MEM_result), .D1(32'b0), .A((EXE2MEM_info[6:3]&'b0000)), .Y(MEM2DR_addr)
);
//MEM2DR_wea
MUX2#(.WIDTH(4))MUX2_wwa(
.D0(4'b0), .D1(EXE2MEM_info[6:3]), .A((EXE2MEM_info[4:0]&'b1000)), .Y(MEM2DR_wea)
);


endmodule
