`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 13:54:12
// Design Name: 
// Module Name: MUX16
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


module MUX16
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
input[WIDTH-1:0]                        D8,
input[WIDTH-1:0]                        D9,
input[WIDTH-1:0]                        D10,
input[WIDTH-1:0]                        D11,
input[WIDTH-1:0]                        D12,
input[WIDTH-1:0]                        D13,
input[WIDTH-1:0]                        D14,
input[WIDTH-1:0]                        D15,
input[3:0]                              A,
output reg[WIDTH-1:0]                   Y
    );
always@(*) begin
    case(A)
    4'd0:Y<=D0;
    4'd1:Y<=D1;
    4'd2:Y<=D2;
    4'd3:Y<=D3;
    4'd4:Y<=D4;
    4'd5:Y<=D5;
    4'd6:Y<=D6;
    4'd7:Y<=D7;
    4'd8:Y<=D8;
    4'd9:Y<=D9;
    4'd10:Y<=D10;
    4'd11:Y<=D11;
    4'd12:Y<=D12;
    4'd13:Y<=D13;
    4'd14:Y<=D14;
    default:Y<=D15;
    endcase
end
endmodule
