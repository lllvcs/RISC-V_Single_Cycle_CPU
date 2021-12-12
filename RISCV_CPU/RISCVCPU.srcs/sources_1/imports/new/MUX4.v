`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 12:40:28
// Design Name: 
// Module Name: MUX4
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


module MUX4
#(
parameter WIDTH=32
)
(
input[WIDTH-1:0]                        D0,
input[WIDTH-1:0]                        D1,
input[WIDTH-1:0]                        D2,
input[WIDTH-1:0]                        D3,
input[1:0]                              A,
output reg[WIDTH-1:0]                   Y
    );
always@(*) begin
    case(A)
    2'b00:Y<=D0;
    2'b01:Y<=D1;
    2'b10:Y<=D2;
    default:Y<=D3;
    endcase
end
endmodule
