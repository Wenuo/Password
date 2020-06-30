`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 14:09:52
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
        reg  clk;
        reg  rst;
        reg  [3:0] row; 
        reg changePass; 
        reg confirmPass;
        reg clearPass;
        wire  [3:0] col;
        wire  lock;
        wire  unlock;
        wire  beef;
        wire  [3:0]    wei;
        wire  [6:0]    duan;
        top_text t(
                .clk(clk),
                .rst(rst),
                .row(row),
                .changePass(changePass),
                .confirmPass(confirmPass),
                .clearPass(clearPass),
                .col(col),
                .lock(lock),
                .unlock(unlock),
                .beef(beef),
                .wei(wei),
                .duan(duan)
        );
        always #10 clk = ~clk;
        initial begin
            clk = 0;
            rst = 0;
            row = 4'b1111;changePass = 0;confirmPass = 0; clearPass = 0;
            #10 rst = 1;
            #50 row = 4'b0111;
            #50 row = 4'b1101;
            #50 row = 4'b1101;
            #50 row = 4'b1011;
            #100 row = 4'b1111; confirmPass = 1;
        end

endmodule
