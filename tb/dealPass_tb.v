`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 20:57:44
// Design Name: 
// Module Name: dealPass_tb
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


module dealPass_tb(
    );
    reg clk;
    reg rst;
    reg error;
    reg right;
    wire lock;
    wire unlock;
    wire beef;
    dealPass deal (
        .clk(clk),
        .rst(rst),
        .error(error),
        .right(right),
        .lock(lock),
        .unlock(unlock),
        .beef(beef)
    );
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rst = 0;
        error = 0;
        right = 0;
        #10 rst = 1;
        #50 right = 1;
        #100 right = 0; error = 1;
        #150 right = 0; error = 1;
        #150 right = 0; error = 1;
        #400 right = 1; error = 0;
        #150 right = 0; error = 1;
        #150 right = 0; error = 1;
        #400 right = 1; error = 0;
    end
endmodule
