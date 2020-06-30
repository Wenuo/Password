`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 21:41:08
// Design Name: 
// Module Name: top_text
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


module top_text(
    input  clk,
    input  rst,
    input  [3:0] row,		
    input changePass, 
    input confirmPass,
    input clearPass,
    output  [3:0] col,
    //output  LED,
    output  lock,
    output  unlock,
    output  beef,
    output  [3:0]	wei,
    output  [6:0]    duan
    
    );
    wire  [3:0]  key_val;
    wire key_en;
    wire error;
    wire right;
    wire [15:0]passvalue;
    wire [15:0] password;

    clearPass u1(
        .clk(clk),
        .rst(rst),
        .keyboard_value(key_val),
        .key_en(key_en),
        .clearPass(clearPass),
        .passvalue(passvalue),
        .password(password)
    );
    confirm u2(
        .clk(clk),
        .rst(rst),
        .changePass(changePass),
        .confirmPass(confirmPass),
        .password(password),
        .error(error),
        .right(right)
    );
    shumaguan u3(
        .clk(clk),
        .rst(rst),
        .passvalue(passvalue),
        .wei(wei),
        .duan(duan)
    );
    dealPass u4(
        .clk(clk),
        .rst(rst),
        .error(error),
        .right(right),
        .lock(lock),
        .unlock(unlock),
        .beef(beef)
    );
        keyboard u5(
        .clk(clk),
        .reset(rst),
        .row(row),
        .col(col),
        .key_val(key_val),
        .key_en(key_en)
        //.LED(LED)
      /*  .changePass(changePass),
        .confirmPass(confirmPass),
        .clearPass(clearPass)*/
    );
endmodule
