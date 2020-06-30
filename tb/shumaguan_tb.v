`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 11:14:57
// Design Name: 
// Module Name: shumaguan_tb
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


module shumaguan_tb(
    );
    reg clk;
    reg rst;
    reg [15:0] passvalue;
    wire     [3:0]    wei;
    wire    [6:0]    duan;
    shumaguan shuma(
            .clk(clk),
            .rst(rst),
            .passvalue(passvalue),
            .wei(wei),
            .duan(duan)
    );
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rst = 0;
        passvalue[3:0] = 4'h4;
        passvalue[7:4] = 4'h7;
        passvalue[11:8] = 4'h8;
        passvalue[15:12] = 4'h1;
        #10 rst = 1;
    end
endmodule
