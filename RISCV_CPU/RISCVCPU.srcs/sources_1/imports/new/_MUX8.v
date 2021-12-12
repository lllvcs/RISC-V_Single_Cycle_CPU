`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 09:23:37
// Design Name: 
// Module Name: _MUX8
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


module _MUX8
#(
parameter WIDTH=32
)
(
input                                   sel0,
input[WIDTH-1:0]                        D0,
input                                   sel1,
input[WIDTH-1:0]                        D1,
input                                   sel2,
input[WIDTH-1:0]                        D2,
input                                   sel3,
input[WIDTH-1:0]                        D3,
input                                   sel4,
input[WIDTH-1:0]                        D4,
input                                   sel5,
input[WIDTH-1:0]                        D5,
input                                   sel6,
input[WIDTH-1:0]                        D6,
input                                   sel7,
input[WIDTH-1:0]                        D7,

output[WIDTH-1:0]                       Y
    );
assign Y=({WIDTH{sel0}}&D0)|({WIDTH{sel1}}&D1)|({WIDTH{sel2}}&D2)|({WIDTH{sel3}}&D3)|({WIDTH{sel4}}&D4)|
({WIDTH{sel5}}&D5)|({WIDTH{sel6}}&D6)|({WIDTH{sel7}}&D7);
endmodule
