`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 21:17:38
// Design Name: 
// Module Name: keyboard
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


module keyboard(
    input  clk,
    input  reset,
    input  [3:0] row,					//输入�?
    output  reg [3:0] col,
    output  reg  [3:0]  key_val,
    //output  reg  LED,
    output  reg  key_en
  //  output  reg  changePass,
 //   output  reg  confirmPass,
  //  output  reg  clearPass 
    );
    reg [20:0]  cnt ;
    always @(posedge clk or negedge reset)
        if(!reset)
            cnt <=0;
         else
            cnt <= cnt +1'b1;
            
      //wire  key_clk = cnt[20];                      //(2^21/100MHZ) = 21ms
      wire key_clk = cnt[3];
      parameter NO_KEY_PRESSED      	=       6'b000_001;
      parameter SCAN_COL0               =       6'b000_010;
      parameter SCAN_COL1               =       6'b000_100;
      parameter SCAN_COL2               =       6'b001_000;
      parameter SCAN_COL3               =       6'b010_000;
      parameter KEY_PRESSED             =       6'b100_000;
      
      reg [5:0]     current_state,next_state;
      
      
      always @(posedge key_clk or negedge reset)
        if(!reset)
            current_state <= NO_KEY_PRESSED;
           else
                current_state <= next_state;
                
         always @(*)
            case (current_state) 
            NO_KEY_PRESSED:
                if (row != 4'hF)
                    next_state = SCAN_COL0;
                 else
                    next_state = NO_KEY_PRESSED;
             SCAN_COL0:
				if (row!=4'hF)
                    next_state = KEY_PRESSED;
                else
                    next_state = SCAN_COL1; 
              SCAN_COL1:
                if (row!=4'hF)
                    next_state = KEY_PRESSED;
                else
                    next_state = SCAN_COL2; 
             SCAN_COL2:
				if (row!=4'hF)
                    next_state = KEY_PRESSED;
                else
                    next_state = SCAN_COL3; 
             SCAN_COL3:
                if (row!=4'hF)
                    next_state = KEY_PRESSED;
                else
                    next_state = NO_KEY_PRESSED; 
             KEY_PRESSED:
                if(row != 4'hF)
                    next_state = KEY_PRESSED;
                else
                    next_state = NO_KEY_PRESSED;
             endcase
             
       reg key_pressed_flag;
       reg [3:0] col_val,row_val;      
     always @(posedge key_clk or negedge reset)
            if (!reset)
				begin 
                       col  			 <= 4'h0 ;
                       key_pressed_flag  <=  0;      
				end
            else
                    case (next_state)
                        NO_KEY_PRESSED:
                        begin
                            col <= 4'h0;
                            key_pressed_flag <= 0;
                            key_en <= 1'b0;
                        end
                        SCAN_COL0:
								col  <= 4'b1110;
                        SCAN_COL1:
                                col  <= 4'b1101;
                        SCAN_COL2:
                                col  <= 4'b1011;
                        SCAN_COL3:
                                col  <= 4'b0111;     
                        KEY_PRESSED:
                            begin
                            col_val         <= col;
                            row_val         <= row;
                            key_pressed_flag <= 1;
                            key_en <= 1'b1;
                            end                                                                                                                                 
                       endcase
                       
                       
         always @(posedge key_clk or negedge reset)
            if(!reset)
               begin
                key_val <=4'b0; 
              //  changePass <= 1'b0;
               // confirmPass <= 1'b0;
              //  clearPass <= 1'b0;
              //  key_en  <= 1'b0;
               end   
            else
            begin
                if (key_pressed_flag)
                    begin
                   // key_en <= 1'b1;
                    case ({col_val,row_val})
                        8'b1110_1110: begin key_val  <= 4'hD;end//LED  <= 1'b0;end//begin confirmPass <= 1'b1;LED<= 1'b1;end//
                        8'b1110_1101: begin key_val  <= 4'hC;end//LED  <= 1'b1;end//begin LED  <= 1'b1;end//
                        8'b1110_1011: begin key_val  <= 4'hB; end//key_en <= 1'b1; end//begin changePass <= 1'b1;end//
                        8'b1110_0111: begin key_val  <= 4'hA; end//key_en <= 1'b1; end// begin clearPass <= 1'b1;LED<= 1'b0;end//begin key_val  <= 4'hA; end//key_en <= 1'b1; end
                        
                        8'b1101_1110: begin key_val  <= 4'hE; end//key_en <= 1'b1; end
                        8'b1101_1101: begin key_val  <= 4'h9; end//key_en <= 1'b1; end
                        8'b1101_1011: begin key_val  <= 4'h6; end//key_en <= 1'b1; end
                        8'b1101_0111: begin key_val  <= 4'h3; end//key_en <= 1'b1; end
                        
                        8'b1011_1110: begin key_val  <= 4'h0; end//key_en <= 1'b1; end
                        8'b1011_1101: begin key_val  <= 4'h8; end//key_en <= 1'b1; end
                        8'b1011_1011: begin key_val  <= 4'h5; end//key_en <= 1'b1; end
                        8'b1011_0111: begin key_val  <= 4'h2; end//key_en <= 1'b1; end
                        
                        8'b0111_1110: begin key_val  <= 4'hF; end//key_en <= 1'b1; end
                        8'b0111_1101: begin key_val  <= 4'h7; end//key_en <= 1'b1; end
                        8'b0111_1011: begin key_val  <= 4'h4; end//key_en <= 1'b1; end
                        8'b0111_0111: begin key_val  <= 4'h1; end//key_en <= 1'b1; end
                        default:;
                     endcase   
                     end
             /*   else 
                           key_en <= 1'b0;*/
               end
endmodule
