`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 20:22:31
// Design Name: 
// Module Name: confirm_tb
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


module confirm_tb(

    );
    reg clk;
    reg rst;
    reg changePass;
    reg confirmPass;
    reg [15:0]password;
    wire  error;
    wire  right;
   // wire [15:0] memory;
    confirm con (
            .clk(clk),
            .rst(rst),
            .changePass(changePass),
            .confirmPass(confirmPass),
            .password(password),
            .error(error),
            .right(right)
    );
        always #10 clk = ~clk;
        initial begin
            clk = 0;
            rst = 0;
            confirmPass = 0;
            changePass = 0;
            password[3:0] = 4'b0001;
            password[7:4] = 4'b1000;
            password[11:8] = 4'b0111;
            password[15:12] = 4'b0100;
            #10 rst = 1;
            #100 confirmPass = 1;
            #500 confirmPass = 0;
            #100 changePass = 1;
            #10    password[3:0] = 4'b0010;
            password[7:4] = 4'b0000;
            password[11:8] = 4'b0001;
            password[15:12] = 4'b0100;
            
            #50 changePass = 0;
            #10             password[3:0] = 4'h4;
            password[7:4] = 4'h7;
            password[11:8] = 4'h8;
            password[15:12] = 4'h1; 
            #50 confirmPass = 1;
             
        end
endmodule
