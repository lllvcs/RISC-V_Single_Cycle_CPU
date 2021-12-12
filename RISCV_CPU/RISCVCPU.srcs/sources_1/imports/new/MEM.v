`timescale 1ns / 1ps

module MEM(
//EXE-MEM
input [6:0]          EXE2MEM_info,//{MEM�洢��дʹ��(6:3),д������(2:0)}
input [31:0]         EXE2MEM_result,//�����޸�ֱ�Ӵ���
input [4:0]          EXE2MEM_result_idx,//�����޸�ֱ�Ӵ���
input [31:0]         EXE2MEM_store_data,//������浽memory��

//��д�洢��
//���洢���Ľ��ֱ�ӴӴ洢���͵�WBģ�飬������MEM
output [31:0]        MEM2DR_addr,//�ô��ַ������Ƿô�ָ���ôEXE2MEM_result���Ƿô��ַ
output [31:0]        MEM2DR_dw,//Ҫ�浽memory�����
output [3:0]         MEM2DR_wea,//дʹ�ܣ�EXE2MEM_info���Ѿ����ˣ��������storeָ�����ֶο϶���ȫ0

//MEM-WB
output [2:0]         MEM2WB_info,//{д������(2:0)}
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
