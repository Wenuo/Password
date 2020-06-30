`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 21:16:27
// Design Name: 
// Module Name: confirm2
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


module clearPass(
    input clk ,
    input rst,
    input [3:0] keyboard_value,
    input key_en,
    input clearPass,
   // output reg [15:0] passvalue,
    output [15:0] passvalue,
    output [15:0] password
    );
    reg [2:0] jishu;
    always @(posedge key_en or negedge rst)
       begin
           if(!rst)
               jishu <= 3'b000;
           else
                begin
                    if(key_en)
                        begin
                            jishu <= jishu +1;     
                                if(jishu == 3'd4)
                                     jishu <= 3'b000;
                        end
                    else
                        jishu <= 3'b000;
                end
       end    
       reg [2:0] count;
    always @(posedge clk or negedge rst)
        begin
            if(!rst)
                count <= 3'd0;
            else
                begin
                    if(clearPass)
                        begin
                            count <= count + 1;
                                if(count == 3'd4)
                                    count <= 3'b000;
                        end
                    else
                        count <= 3'b000;
                end
        end

    reg [3:0] value1,value2,value3,value4;
    reg [15:0] passvalue3,passvalue2;
    always @(posedge clk or negedge rst)
        begin
            if(!rst)
                 begin
                    passvalue3 <= 16'd0;
                     value1      <= 4'd0;
                     value2      <= 4'd0;
                     value3      <= 4'd0;
                     value4      <= 4'd0;
                 end
           /* else  if(clearPass)
                     passvalue <= 16'd0;    */
        else if(clearPass)
            begin
                      case(count)
                           3'b001:  value1 <= 4'b0000;
                           3'b010:  value2 <= 4'b0000;
                           3'b011:  value3 <= 4'b0000;
                           3'b100:  value4 <= 4'b0000; 
                           default: begin value1 <= value1; value2 <= value2; value3 <= value3; value4 <= value4; end
                       endcase 
           end
     else 
            begin
                case(jishu)
                    3'b001:  value1  <= keyboard_value[3:0]; 
                    3'b010:  value2  <= keyboard_value[3:0]; 
                    3'b011:  value3  <= keyboard_value[3:0]; 
                    3'b100:  value4  <= keyboard_value[3:0]; 
                    default:;
                endcase
                case(jishu)
                    3'b001:  passvalue3 <= {4'b0000,4'b0000,4'b0000,value1};
                    3'b010:  passvalue3 <= {4'b0000,4'b0000,value1,value2};
                    3'b011:  passvalue3 <= {4'b0000,value1,value2,value3}; 
                    3'b100:  passvalue3 <= {value1,value2,value3,value4}; 
                    default:;
                endcase
                
               /* case(count)
                    3'b001:  passvalue2 <= {value1,value2,value3,4'b0000}; 
                    3'b010:  passvalue2 <= {value1,value2,4'b0000,4'b0000};
                    3'b011:  passvalue2 <= {value1,4'b0000,4'b0000,4'b0000};
                    3'b100:  passvalue2 <= {4'b0000,4'b0000,4'b0000,4'b0000}; 
                    default: passvalue2 <= passvalue2;
                endcase  */
            end   
                    
        end
        assign passvalue = passvalue3;
        //assign passvalue = (clearPass) ? passvalue2:passvalue3;
        assign password = {value1,value2,value3,value4};
endmodule
