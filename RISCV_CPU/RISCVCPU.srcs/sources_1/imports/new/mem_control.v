`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/04 15:25:56
// Design Name: 
// Module Name: mem_control
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


module mem_control(
input               CLK,
input               RSTn,

input               RAW_block,
input               J_sig,

//IF¶Á¶Ë¿Ú
input[31:0]         PC,
output[31:0]        INST,

output[31:0]        addra,
output[31:0]        dwa,
input[31:0]         dra,       
output              ena,
output[3:0]         wea,     

//·Ã´æ¶Ë¿Ú
input[31:0]         MEM2DR_addr,
input[31:0]         MEM2DR_dw,
input[3:0]          MEM2DR_wea,
output[31:0]        DR2WB_dr_reg,
output[31:0]        DR2WB_ior_reg,
output              DR2WB_io_sig_reg,

output[31:0]        addrb,
output[31:0]        dwb,
input[31:0]         drb,       
output              enb,
output[3:0]         web,

//IO¶Ë¿Ú
output[31:0]        addrio,
output[31:0]        dwio,
input[31:0]         drio,       
output              enio,
output[3:0]         weio,
output              rstio 
    );
wire RST;assign RST=~RSTn;
//´¦Àí×èÈû
wire[31:0] _PC;
assign _PC=(J_sig|RST)? 32'd4:PC;

//IF¶Ë¿Ú
assign INST=(RST|J_sig)? 32'd0:dra;
assign addra=_PC;
assign dwa='d0;
assign ena=~RAW_block;
assign wea=4'd0;

//·Ã´æ¶Ë¿Ú
assign DR2WB_dr_reg=drb;
assign DR2WB_ior_reg=drio;
REG_HE#(.WIDTH(1))REG0(.CLK(CLK),.RST(RST),.E(1'b1),.H(1'b0),.in(MEM2DR_addr[31]),.out(DR2WB_io_sig_reg));
assign addrb=(MEM2DR_addr[31])? 32'd0:MEM2DR_addr;
assign dwb=(MEM2DR_addr[31])? 32'd0:MEM2DR_dw;
assign enb=1'b1;
assign web=(MEM2DR_addr[31])? 4'd0:MEM2DR_wea;

//IO¶Ë¿Ú
assign addrio=(MEM2DR_addr[31])? {1'b0,MEM2DR_addr[30:0]}:32'd0;
assign dwio=(MEM2DR_addr[31])? MEM2DR_dw:32'd0;
assign enio=1'b1;
assign weio=(MEM2DR_addr[31])? MEM2DR_wea:4'd0;
assign rstio=1'b0;

endmodule
