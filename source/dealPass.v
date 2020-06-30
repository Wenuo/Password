`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 20:35:47
// Design Name: 
// Module Name: dealPass
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


module dealPass(
    input clk,
    input rst,
    input error,
    input right,
    output reg lock,
    output reg unlock,
    output reg beef
    );
    reg [1:0]error_cnt;
    reg [3:0] beef_cnt;
   always @(posedge clk or negedge rst)
       begin
            if(!rst)
                  beef_cnt <= 4'd0;
            //else if(beef_cnt == 16'd49999)
            else if(beef_cnt == 9)
                  beef_cnt <= 4'd0;
             else
                   beef_cnt <= beef_cnt + 1'b1;
         end        
    always @(posedge clk or negedge rst)
        begin
            if(!rst)
                    error_cnt <= 2'b00;
            else
                begin
                     if(error)
                            begin
                                    error_cnt <= error_cnt +1;     
                                            if(error_cnt == 2'd3)
                                                             error_cnt <= 2'b00;
                            end
                    else
                            error_cnt <= 2'b00;
                  end  
        end
    always @(posedge clk or negedge rst)
        begin
            if(!rst)
                begin
                    lock <= 1'b0;
                    unlock <= 1'b0;
                end
            else 
                begin
                    if(right)
                        begin
                            unlock <= 1'b1;
                            lock <= 1'b0;
                        end
                    else if(error)
                        begin
                            unlock <= 1'b0;
                            lock <= 1'b1;
                        end
                 end
        end
       always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    beef <= 1'b0;
                else if(error&&error_cnt == 2'd3)
                    begin
                        if(beef_cnt == 4'd9)
                            beef <= ~beef;
                        else
                            beef <= beef;
                    end
                else 
                    beef <= 0; 
            end
endmodule
