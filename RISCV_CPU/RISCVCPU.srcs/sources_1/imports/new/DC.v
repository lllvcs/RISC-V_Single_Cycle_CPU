`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//����
//0000 0000 000 000
//��ת���ͣ�4λ����
//0������ת
//1��JAL
//2��JALR
//3��������ת
//4����������ת
//5��С����ת���з�������
//6��С����ת���޷�������
//7�����ڵ�����ת���з�������
//8�����ڵ�����ת���޷�������
//
//�������ͣ�4λ����
//0���ӷ�
//1������
//2��С����λ���з�������
//3��С����λ���޷�������
//4����λ��
//5����λ��
//6����λ���
//7���߼�����
//8���߼�����
//9����������
//
//д�����ͣ�3λ����
//0����д��
//1��������д��
//2���ô�32λ���д��
//3���ô�16λ������չȻ��д��
//4���ô�16λ��λ��0Ȼ��д��
//5���ô�8λ������չȻ��д��
//6���ô�8λ��λ��0Ȼ��д��
//////////////////////////////////////////////////////////////////////////////////


module DC(
//IF-DC
input[31:0]         INST,//32λָ��
input[31:0]         PC,

//DC-REG
output [4:0]    DC2REG_idx0,//������0�ļĴ����ţ�Ҫ�󣺲�����0�������ڼĴ���ʱ������źű���Ϊ0
output [4:0]    DC2REG_idx1,//������1�ļĴ����ţ�Ҫ��ͬ��
input[31:0]         REG2DC_data0,
input[31:0]         REG2DC_data1,

//DC-EXE    
output [14:0]        DC2EXE_info,//{EXE��ת����(14:11),EXE��������(10:7),MEM�洢��дʹ��(6:3),д������(2:0)}
output [31:0]        DC2EXE_OP0,//����ת��ָ�rs1��ֵ���ô�ָ�����ַ��AUIPC��JAL��JALR��PC
output [31:0]        DC2EXE_OP1,//����ת��ָ�rs2��ֵ���ô�ָ���ַƫ������AUIPC������������12λ��JAL��JALR��4
output [31:0]        DC2EXE_PC,//��EXE�׶κ�PC_offset��ӣ��ó�ת��ָ�����ת��ַ
output [31:0]        DC2EXE_PC_offset0,//JAL������ת�ƣ�����������1λ��JALR��������
output [31:0]        DC2EXE_PC_offset1,//JALR��rs1��ֵ��������0
output [31:0]        DC2EXE_store_data,//storeָ��Ҫ�����
output [4:0]         DC2EXE_result_idx//Ŀ�ļĴ������� 

    );

//ָ��
wire LUI,AUIPC,JAL,JALR,BEQ,BNE,BLT,BGE;
assign LUI=(INST[6:0]==7'b0110111);
assign AUIPC=(INST[6:0]==7'b0010111);
assign JAL=(INST[6:0]==7'b1101111);
assign JALR=(INST[6:0]==7'b1100111)&(INST[14:12]==3'b000);
assign BEQ=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b000);
assign BNE=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b001);
assign BLT=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b100);
assign BGE=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b101);
wire BLTU,BGEU,LB,LH,LW,LBU,LHU,SB;
assign BLTU=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b110);
assign BGEU=(INST[6:0]==7'b1100011)&(INST[14:12]==3'b111);
assign LB=(INST[6:0]==7'b0000011)&(INST[14:12]==3'b000);
assign LH=(INST[6:0]==7'b0000011)&(INST[14:12]==3'b001);
assign LW=(INST[6:0]==7'b0000011)&(INST[14:12]==3'b010);
assign LBU=(INST[6:0]==7'b0000011)&(INST[14:12]==3'b100);
assign LHU=(INST[6:0]==7'b0000011)&(INST[14:12]==3'b101);
assign SB=(INST[6:0]==7'b0100011)&(INST[14:12]==3'b000);
wire SH,SW,ADDI,SLTI,SLTIU,XORI,ORI,ANDI;
assign SH=(INST[6:0]==7'b0100011)&(INST[14:12]==3'b001);
assign SW=(INST[6:0]==7'b0100011)&(INST[14:12]==3'b010);
assign ADDI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b000);
assign SLTI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b010);
assign SLTIU=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b011);
assign XORI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b100);
assign ORI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b110);
assign ANDI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b111);
wire SLLI,SRLI,SRAI,ADD,SUB,SLL,SLT,SLTU;
assign SLLI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b001)&(INST[31:25]==7'b0000000);
assign SRLI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b101)&(INST[31:25]==7'b0000000);
assign SRAI=(INST[6:0]==7'b0010011)&(INST[14:12]==3'b101)&(INST[31:25]==7'b0100000);
assign ADD=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b000)&(INST[31:25]==7'b0000000);
assign SUB=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b000)&(INST[31:25]==7'b0100000);
assign SLL=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b001)&(INST[31:25]==7'b0000000);
assign SLT=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b010)&(INST[31:25]==7'b0000000);
assign SLTU=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b011)&(INST[31:25]==7'b0000000);
wire XOR,SRL,SRA,OR,AND,NOP;
assign XOR=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b100)&(INST[31:25]==7'b0000000);
assign SRL=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b101)&(INST[31:25]==7'b0000000);
assign SRA=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b101)&(INST[31:25]==7'b0100000);
assign OR=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b110)&(INST[31:25]==7'b0000000);
assign AND=(INST[6:0]==7'b0110011)&(INST[14:12]==3'b111)&(INST[31:25]==7'b0000000);
assign NOP=(INST[6:0]==7'b0000000);

//ָ�����
wire op,opi,ld,st,b,si;
assign op=(ADD|SUB|SLL|SLT|SLTU|XOR|SRL|SRA|OR|AND);
assign opi=(ADDI|SLTI|SLTIU|XORI|ORI|ANDI);
assign ld=(LB|LH|LW|LBU|LHU);
assign st=(SB|SH|SW);
assign b=(BEQ|BNE|BLT|BGE|BLTU|BGEU);
assign si=(SLLI|SRLI|SRAI);


//DC2REG_idx0
_MUX8#(.WIDTH(5))MUX8_reg0(
.sel0(LUI|AUIPC), .D0(INST[11:7]), .sel1(JAL|JALR), .D1( 5'b0), .sel2(op), .D2(INST[19:15]), .sel3(opi), .D3(INST[19:15]),
 .sel4(ld), .D4(INST[19:15]), .sel5(st), .D5(INST[19:15]), .sel6(b), .D6(INST[19:15]), .sel7(si), .D7(INST[19:15]),.Y(DC2REG_idx0)
);

//DC2REG_idx1
MUX2#(.WIDTH(5))MUX2_reg2(
.D0(5'b0), .D1(INST[24:20]), .A(op|b), .Y(DC2REG_idx1)
);

//DC2EXE_info
wire [14:0] temp0_DC2EXE_info;
wire [14:0] temp1_DC2EXE_info;
wire [14:0] temp2_DC2EXE_info;

_MUX16#(.WIDTH(15))_MUX16_info0(
.sel0(ADD),.D0(15'b000000000000001),.sel1(SUB),.D1(15'b000000010000001),.sel2(SLL),.D2(15'b000001110000001),.sel3(SLT),.D3(15'b000000010000001),.sel4(SLTU),.D4(15'b000000010000001),
.sel5(XOR),.D5(15'b000001100000001),.sel6(SRL),.D6(15'b000010000000001),.sel7(SRA),.D7(15'b000010010000001),.sel8(OR),.D8(15'b000001010000001),.sel9(AND),.D9(15'b000001000000001),
.sel10(ADDI),.D10(15'b000000000000001),.sel11(SLTI),.D11(15'b000001110000001),.sel12(SLTIU),.D12(15'b000001110000001),.sel13(XORI),.D13(15'b000001100000001),
.sel14(ORI),.D14(15'b000001010000001),.sel15(ANDI),.D15(15'b000001000000001),.Y(temp0_DC2EXE_info)
);
_MUX8#(.WIDTH(15))_MUX8_info0(
.sel0(LB),.D0(15'b000000000000101),.sel1(LH),.D1(15'b000000000000011),.sel2(LW),.D2(15'b000000000000010),.sel3(LBU),.D3(15'b000000000000110),
.sel4(LHU),.D4(15'b000000000000100),.sel5(SB),.D5(15'b000000001111000),.sel6(SH),.D6(15'b000000000011000),.sel7(SW),.D7(15'b000000000001000),.Y(temp1_DC2EXE_info)
);
_MUX16#(.WIDTH(15))_MUX16_info1(
.sel0(BEQ),.D0(15'b001100010000000),.sel1(BNE),.D1(15'b010000010000000),.sel2(BLT),.D2(15'b010100010000000),.sel3(BGE),.D3(15'b011100010000000),
.sel4(BLTU),.D4(15'b011000010000000),.sel5(BGEU),.D5(15'b100000010000000),.sel6(SLLI),.D6(15'b000001110000001),.sel7(SRLI),.D7(15'b000010000000001),
.sel8(SRAI),.D8(15'b000010010000001),.sel9(LUI),.D9(15'b000000000000000),.sel10(AUIPC),.D10(15'b000000000000000),.sel11(JAL),.D11(15'b000100000000001),
.sel12(JALR),.D12(15'b001000000000000),.sel13(0),.D13(15'b0),.sel14(0),.D14(15'b0),.sel15(0),.D15(15'b0),.Y(temp2_DC2EXE_info)
);
_MUX8#(.WIDTH(15))_MUX8_info_sum(
.sel0(op|opi),.D0(temp0_DC2EXE_info),.sel1(ld|st),.D1(temp1_DC2EXE_info),.sel2(b|si|LUI|AUIPC|JAL|JALR),.D2(temp2_DC2EXE_info),.sel3(1'b0),.D3(15'b0),
.sel4(1'b0),.D4(15'b0),.sel5(1'b0),.D5(15'b0),.sel6(1'b0),.D6(15'b0),.sel7(1'b0),.D7(15'b0),.Y(DC2EXE_info)
);



// DC2EXE_OP0
_MUX8#(.WIDTH(32))MUX8_OP0(
.sel0(LUI|AUIPC), .D0(PC), .sel1(JAL|JALR), .D1(PC), .sel2(op), .D2(REG2DC_data0), .sel3(opi), .D3(REG2DC_data0),
 .sel4(ld), .D4(REG2DC_data0), .sel5(st), .D5(REG2DC_data0), .sel6(b), .D6(REG2DC_data0), .sel7(si), .D7(REG2DC_data0),.Y(DC2EXE_OP0)
);
// DC2EXE_OP1
_MUX8#(.WIDTH(32))MUX8_OP1(
.sel0(LUI|AUIPC), .D0({{INST[31:12]},{12'b0}}), .sel1(JAL|JALR), .D1({{29'b0},{3'b100}}), .sel2(op), .D2(REG2DC_data1), .sel3(opi), .D3({{20{INST[31]}},INST[31:20]}),
 .sel4(ld), .D4(REG2DC_data1), .sel5(st), .D5(REG2DC_data1), .sel6(b), .D6(REG2DC_data1), .sel7(si), .D7(REG2DC_data1),.Y(DC2EXE_OP1)
);
// DC2EXE_PC
assign DC2EXE_PC = PC;
// DC2EXE_PC_offset0
_MUX8#(.WIDTH(32))MUX8_ofs0(
.sel0(JAL), .D0({{12{INST[31]}},INST[19:12],INST[20],INST[30:21],1'b0}), .sel1(JALR), .D1( {{20{INST[31]}},{INST[31:20]}}),
 .sel2(b), .D2({{20{INST[31]}},{INST[7]},{INST[30:25]},{INST[11:8]},{1'b0}}), .sel3(1'b0), .D3(32'b0),
 .sel4(1'b0), .D4(32'b0), .sel5(1'b0), .D5(32'b0), .sel6(1'b0), .D6(32'b0), .sel7(1'b0), .D7(32'b0),.Y(DC2EXE_PC_offset0)
);
// DC2EXE_PC_offset1
MUX2#(.WIDTH(32))MUX2_ofs1(
.D0(32'b0), .D1(REG2DC_data0), .A(JALR), .Y(DC2EXE_PC_offset1)
);

// DC2EXE_store_data
assign DC2EXE_store_data = INST[24:20];
// DC2EXE_result_idx
assign DC2EXE_result_idx = INST[11:7];




endmodule
