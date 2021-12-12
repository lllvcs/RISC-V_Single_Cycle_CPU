`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 15:46:56
// Design Name: 
// Module Name: REG_HE
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


module REG_HE
#(
parameter WIDTH=32
)
(
input                             CLK,
input                             RST,
input                             E,//同步使能
input                             H,//hold
input[WIDTH-1:0]                  in,
output reg[WIDTH-1:0]             out
);
always@(posedge CLK or posedge RST) begin
    if(RST) begin
        out<='d0;
    end
    else if(H) begin
        out<=out;
    end
    else if(~E) begin
        out<='d0;
    end
    else begin
        out<=in;
    end
end
endmodule
