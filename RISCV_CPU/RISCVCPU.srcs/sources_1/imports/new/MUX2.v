`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 12:39:51
// Design Name: 
// Module Name: MUX2
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


module MUX2
#(
parameter WIDTH=32
)
(
input[WIDTH-1:0]                        D0,
input[WIDTH-1:0]                        D1,
input                                   A,
output reg[WIDTH-1:0]                   Y
    );
always@(*) begin
    case(A)
    1'b0:Y<=D0;
    default:Y<=D1;
    endcase
end
endmodule
