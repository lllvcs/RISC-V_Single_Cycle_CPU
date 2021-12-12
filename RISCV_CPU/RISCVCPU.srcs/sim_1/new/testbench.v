`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/09 19:08:29
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
reg CLK,RSTn;
    initial begin
        CLK<=1'b0;
        RSTn<=1'b1;
        #40 RSTn<=1'b0;
        #40 RSTn<=1'b1;
    end
    always #10 CLK<=~CLK;
    
    TOP_wrapper Tw(
        .CLK_0(CLK),
        .RSTn_0(RSTn)
    );
endmodule
