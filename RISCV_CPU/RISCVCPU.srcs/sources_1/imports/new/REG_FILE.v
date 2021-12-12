`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/15 22:23:40
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
input               CLK,
input               RST,
//DC-REG
input[4:0]          DC2REG_idx0,
input[4:0]          DC2REG_idx1,
output reg[31:0]    REG2DC_data0,
output reg[31:0]    REG2DC_data1,

//WB-REG
//WB-REG
input[31:0]         WB2REG_result,
input[4:0]          WB2REG_result_idx,
input               WB2REG_wea
    );
reg[31:0] regfile[31:0];
always @(*) begin
    if(DC2REG_idx0=='d0) begin
        REG2DC_data0<=32'd0;
    end
    else begin
        REG2DC_data0<=regfile[DC2REG_idx0];
    end
end
always @(*) begin
    if(DC2REG_idx1=='d0) begin
        REG2DC_data1<=32'd0;
    end
    else begin
        REG2DC_data1<=regfile[DC2REG_idx1];
    end
end
always @(posedge CLK or posedge RST) begin
    if(RST) begin
        regfile[2]<=32'd204800;
        regfile[3]<=32'd0;
        regfile[4]<=32'd0;
        regfile[5]<=32'd0;
        regfile[6]<=32'd0;
        regfile[7]<=32'd0;
        regfile[8]<=32'd0;
        regfile[9]<=32'd0;
    end
    else if(WB2REG_wea&(WB2REG_result_idx!=32'd0)) begin
        regfile[WB2REG_result_idx]<=WB2REG_result;
    end
end
endmodule
