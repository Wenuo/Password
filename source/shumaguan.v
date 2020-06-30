`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 21:50:22
// Design Name: 
// Module Name: shumaguan
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


module shumaguan(
    input clk,
    input rst,
    input [15:0] passvalue,
	output reg 	[3:0]	wei,
    output reg    [6:0]    duan
  //  output reg  [3:0]  value
    );
    reg [3:0] Dn;
    reg [19:0] cnt;
    always @(posedge clk or negedge rst)
        begin
            if(!rst)
                cnt <= 0;
            else
                cnt <= cnt + 1;
        end
    always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    wei <= 4'b1111;
                else
                    case(cnt[3:2])
                    //case(cnt[19:18])
                        2'b00 : wei      <= 4'b0001;
                        2'b01 : wei      <= 4'b0010;
                        2'b10 : wei      <= 4'b0100;
                        2'b11 : wei      <= 4'b1000;
                     default:  wei      <=  4'b0000;
                     endcase
            end    
            
        always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    Dn <= 0;
                else
                    case(wei)
                        4'b0001:   Dn <= passvalue[3:0]; 
                        4'b0010:   Dn <= passvalue[7:4];
                        4'b0100:   Dn <= passvalue[11:8];
                        4'b1000:   Dn <= passvalue[15:12];
                        default:;
                     endcase
            end
        always @(posedge clk or negedge rst)
            begin
                if(!rst)
                    duan <= 7'b0000001;
                else
                    begin
                    case(Dn)
                            4'b0000:  duan =    7'b1111_110;  
                            4'b0001:  duan =    7'b0110_000;   
                            4'b0010:  duan =    7'b1101_101;    
                            4'b0011:  duan =    7'b1111_001;    
                            4'b0100:  duan =    7'b0110_011;  
                            4'b0101:  duan =    7'b1011_011;  
                            4'b0110:  duan =    7'b1011_111;    
                            4'b0111:  duan =    7'b1110_000;   
                            4'b1000:  duan =    7'b1111_111;  
                            4'b1001:  duan =    7'b1111_011;   
                            4'b1010:  duan =    7'b1110_111;
                            4'b1011:  duan =    7'b0011_111;           
                            4'b1100:  duan =    7'b1001_110;       
                            4'b1101:  duan =    7'b0111_101;           
                            4'b1110:  duan =    7'b1001_111;           
                            4'b1111:  duan =    7'b1000_111; 
                           default:    duan =    7'b0000_001;       
                       endcase    
                     end          
            end

endmodule
