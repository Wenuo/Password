`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 10:50:45
// Design Name: 
// Module Name: clearPass_tb
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


module clearPass_tb(

    );
    reg clk ;
    reg rst;
    reg [3:0] keyboard_value;
    reg key_en;
    reg clearPass;
   // output reg [15:0] passvalue,
    wire [15:0] passvalue;
    wire [15:0] password;
    
    clearPass clear(
        .clk(clk),
        .rst(rst),
        .keyboard_value(keyboard_value),
        .key_en(key_en),
        .clearPass(clearPass),
        .passvalue(passvalue),
        .password(password)
    );
    
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rst = 0;
        key_en = 0;
        clearPass = 0;
        #10 rst = 1;
        #50 keyboard_value = 4'h1; key_en = 1;
        #50 key_en = 0;
        #50 keyboard_value = 4'h8; key_en = 1;
        #50 key_en = 0;
        #50 keyboard_value = 4'h7; key_en = 1;
        #50 key_en = 0;
        #50 keyboard_value = 4'h4; key_en = 1;
        #50 key_en = 0;
        #100 clearPass = 1;
        #100   clearPass = 0;
        #100 clearPass = 1;
        #100   clearPass = 0;
         #100 clearPass = 1;
        #100   clearPass = 0;
         #100 clearPass = 1;
        #100   clearPass = 0;
    end
endmodule
