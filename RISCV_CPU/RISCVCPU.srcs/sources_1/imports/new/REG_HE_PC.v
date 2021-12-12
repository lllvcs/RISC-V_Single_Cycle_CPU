`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 09:43:56
// Design Name: 
// Module Name: REG_HE_PC
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


module REG_HE_PC
#(
parameter WIDTH=32
)
(
input                             CLK,
input                             RST,
input                             E,//同步使能
input                             H,//hold
input                             J_block,
input                             J_sig,
input[WIDTH-1:0]                  in,
output [WIDTH-1:0]                out,
output [WIDTH-1:0]                out_f
);
reg[31:0] PC;
always@(posedge CLK or posedge RST) begin
    if(RST) begin
        PC<=32'd0;
    end
    else if(H) begin
        PC<=PC;
    end
    else begin
        PC<=in;
    end
end
assign out=(E)? PC:'d4;
endmodule
