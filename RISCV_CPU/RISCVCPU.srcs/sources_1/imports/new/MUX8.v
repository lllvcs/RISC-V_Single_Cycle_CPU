`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 20:28:46
// Design Name: 
// Module Name: MUX8
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


module MUX8
#(
parameter WIDTH=32
)
(
input[WIDTH-1:0]                        D0,
input[WIDTH-1:0]                        D1,
input[WIDTH-1:0]                        D2,
input[WIDTH-1:0]                        D3,
input[WIDTH-1:0]                        D4,
input[WIDTH-1:0]                        D5,
input[WIDTH-1:0]                        D6,
input[WIDTH-1:0]                        D7,
input[2:0]                              A,
output reg[WIDTH-1:0]                   Y
    );
always@(*) begin
    case(A)
    3'd0:Y<=D0;
    3'd1:Y<=D1;
    3'd2:Y<=D2;
    3'd3:Y<=D3;
    3'd4:Y<=D4;
    3'd5:Y<=D5;
    3'd6:Y<=D6;
    default:Y<=D7;
    endcase
end
endmodule
