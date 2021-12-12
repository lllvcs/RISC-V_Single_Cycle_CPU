`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//ִ��
//
//����ָ���У������������ͣ���OP0��OP1����Ӧ�����㣬�ó���������EXE2MEM_result��
//��תָ���У�������ת���ͣ��ж�OP0��OP1�Ƿ�������ת�������ó���ת��־λ��EXE2IF_j_sig��
//
//DC2EXE_PC��DC2EXE_PC_offset0��DC2EXE_PC_offset1�������ֶ�ֻ���ڼ�����ת��ַ
//RISCVָ��е���תȫ�����������ת����Ҫ��PC��PCƫ������ӣ��ó���ת�ľ��Ե�ַ
//JALRָ��Ƚ����⣬Ҫ��rs1�е�ֵ��ƫ������ӣ��ó���ת�ľ��Ե�ַ
//��ˣ�JALR����ת��ַΪoffset0+offset1��������תָ�����ת��ַΪPC+offset0
//////////////////////////////////////////////////////////////////////////////////
`define Branch 1'b1             //����ת��
`define NotBranch 1'b0          //������ת��


module EXE(
//DC-EXE    
input[14:0]         DC2EXE_info,//{EXE��ת����(14:11),EXE��������(10:7),MEM�洢��дʹ��(6:3),д������(2:0)}
input[31:0]         DC2EXE_OP0,//����ת��ָ�rs1��ֵ���ô�ָ�����ַ��AUIPC��JAL��JALR��PC
input[31:0]         DC2EXE_OP1,//����ת��ָ�rs2��ֵ���ô�ָ���ַƫ������AUIPC������������12λ��JAL��JALR��4
input[31:0]         DC2EXE_PC,//�����������������ӣ����Եó�EXE2IF_j_PC
input[31:0]         DC2EXE_PC_offset0,//�����������������ӣ����Եó�EXE2IF_j_PC
input[31:0]         DC2EXE_PC_offset1,//�����������������ӣ����Եó�EXE2IF_j_PC
input[31:0]         DC2EXE_store_data,//�����޸�ֱ�Ӵ��ݸ�EXE2MEM_store_data
input[4:0]          DC2EXE_result_idx,//�����޸�ֱ�Ӵ���


//EXE-MEM
output[6:0]         EXE2MEM_info,//{MEM�洢��дʹ��(6:3),д������(2:0)}
output  [31:0]   EXE2MEM_result,
output[4:0]         EXE2MEM_result_idx,
output[31:0]        EXE2MEM_store_data,
output[3:0]         JUMPType,
output[3:0]         COMType,
//output reg[31:0]       out,
//output reg             carryout,overflow,zero,

//EXE-IFת��ָ��
output              EXE2IF_j_sig,//��OP0��OP1����ת���͵ó�
output [31:0]        EXE2IF_j_PC
    );

assign EXE2MEM_info =  DC2EXE_info[6:0];
assign COMType = DC2EXE_info[10:7];
assign JUMPType = DC2EXE_info[14:11];
assign EXE2MEM_store_data = DC2EXE_store_data;
assign EXE2MEM_result_idx = DC2EXE_result_idx;
 
 
 
 
 
 // ������ 16·
wire [31:0] add_result;
wire [31:0] sub_result ;
wire [31:0]slt_result;
wire [31:0]sltu_result;
wire [31:0]and_result;
wire [31:0]or_result;
wire [31:0]xor_result;
wire [31:0]sll_result;
wire [31:0]srl_result;
wire [31:0]sra_result;
assign add_result = DC2EXE_OP0 + DC2EXE_OP1;
assign sub_result = DC2EXE_OP0 - DC2EXE_OP1;
assign slt_result = {31'd0,(DC2EXE_OP0 < DC2EXE_OP1)};
assign sltu_result = {31'd0,(DC2EXE_OP0 < DC2EXE_OP1)};
assign and_result = DC2EXE_OP0 & DC2EXE_OP1;
assign or_result = DC2EXE_OP0 | DC2EXE_OP1;
assign xor_result = DC2EXE_OP0 ^ DC2EXE_OP1;
assign sll_result = DC2EXE_OP0 << DC2EXE_OP1;
assign srl_result = DC2EXE_OP0 >> DC2EXE_OP1;
assign sra_result = DC2EXE_OP0 >>> DC2EXE_OP1;

// ������ת�ж�
wire beq_bne_result;
assign beq_bne_result = (DC2EXE_OP0 == DC2EXE_OP1);
wire [31:0] usigned_sub;
assign usigned_sub = DC2EXE_OP0 - DC2EXE_OP1;
wire signed_less;
assign signed_less = (((DC2EXE_OP0[31])&(~DC2EXE_OP1[31])) | ((~DC2EXE_OP0[31])&(~DC2EXE_OP1[31])&(usigned_sub[31]) ) 
| ((DC2EXE_OP0[31])&(DC2EXE_OP1[31])&(usigned_sub[31])));

// EXE2MEM_result
MUX16#(.WIDTH(32))MUX16_result(
 .D0(add_result), .D1(sub_result), .D2(slt_result), .D3(sltu_result), .D4(and_result), .D5(or_result),
 .D6(xor_result), .D7(sll_result), .D8(srl_result), .D9(sra_result), .D10(32'b0), .D11(32'b0),
 .D12(32'b0), .D13(32'b0), .D14(32'b0), .D15(32'b0), .A(DC2EXE_info[10:7]), .Y(EXE2MEM_result)
 );
 
 // EXE2IF_j_sig��ת�ź� 
  MUX16#(.WIDTH(1))MUX16_sig(
  .D0(1'b0), .D1(1'b1), .D2(1'b1), .D3( beq_bne_result ), .D4( (~beq_bne_result) ), .D5( (signed_less) ),
   .D6( (usigned_sub[31]) ), .D7( (~signed_less) ), .D8( (~usigned_sub[31]) ), .D9(1'b0), .D10(1'b0), .D11(1'b0),
    .D12(1'b0), .D13(1'b0), .D14(1'b0), .D15(1'b0), .A(DC2EXE_info[14:11]), .Y(EXE2IF_j_sig)
  );
  
 // ��תPC
wire [31:0] jal_jpc;
wire [31:0] jalr_jpc;
 assign jal_jpc = DC2EXE_PC + DC2EXE_PC_offset0;
 assign jalr_jpc =   DC2EXE_PC_offset0+ DC2EXE_PC_offset1;
 
 MUX16#(.WIDTH(32))MUX16_jpc(
  .D0(32'b0), .D1(jal_jpc), .D2(jalr_jpc), .D3(jal_jpc), .D4(jal_jpc), .D5(jal_jpc),
   .D6(jal_jpc), .D7(jal_jpc), .D8(jal_jpc), .D9(32'b0), .D10(32'b0), .D11(32'b0),
    .D12(32'b0), .D13(32'b0), .D14(32'b0), .D15(32'b0), .A(DC2EXE_info[14:11]), .Y(EXE2IF_j_PC)
  );
 
 

endmodule
