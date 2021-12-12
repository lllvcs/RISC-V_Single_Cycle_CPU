`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//д�����ͣ�
//0��д�أ�1������д�أ�2�ô�32λ���д�أ�3�ô�16λ������չ
//4�ô�16λ��λ��0��5�ô�8λ������չ��6�ô�8λ��λ��0��7��io32λ���д��
//////////////////////////////////////////////////////////////////////////////////


module WB(
//MEM-WB
input[2:0]         MEM2WB_info,//{д������(2:0)}
input[31:0]        DR2WB_dr,//���ڴ��ж���ֵ
input[31:0]        DR2WB_ior,//���ڴ��ж�����ֵ
input              DR2WB_io_sig,//����ź�Ϊ1��˵��������IO�Σ���ַ����0x80000000�����������ݶΣ�������ֵ��DR2WB_ior����
input[31:0]        MEM2WB_result,//EXE������
input[4:0]         MEM2WB_result_idx,//Ŀ�ļĴ�����

//WB-REG
output  [31:0]       WB2REG_wb_data,//д�ص�����
output  [4:0]        WB2REG_wb_idx,//Ŀ�ļĴ�������
output             WB2REG_wea//дʹ��

    );

//д������ WB2REG_wea
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