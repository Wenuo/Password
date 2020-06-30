`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 20:05:34
// Design Name: 
// Module Name: confirm
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


module confirm(
        input clk,
        input rst,
        input changePass,
        input confirmPass,
        input [15:0]password,
        output reg error,
        output reg right
    );
        reg [3:0] m_pass[3:0];
        always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    begin
                        m_pass[0] <= 4'd4;
                        m_pass[1] <= 4'd7;
                        m_pass[2] <= 4'd8;
                        m_pass[3] <= 4'd1;
                    end
                else
                    if(changePass)
                        begin
                            m_pass[0] <= password[3:0];
                            m_pass[1] <= password[7:4];
                            m_pass[2] <= password[11:8];
                            m_pass[3] <= password[15:12];
                        end
            end
        reg [15:0] container;
         always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    begin
                        container <= 16'd0;
                        error <= 1'b0;
                        right <= 1'b0;
                    end
                else if(confirmPass)
                        begin
                            container[3:0] <= m_pass[0];
                            container[7:4] <= m_pass[1];
                            container[11:8] <= m_pass[2];
                            container[15:12] <= m_pass[3];
                            if(password == container)
                                begin
                                    right <= 1'b1;
                                    error <= 1'b0;
                                end
                            else
                                begin
                                    right <= 1'b0;
                                    error <= 1'b1;
                                end
                        end
            end
endmodule
