`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 21:58:53
// Design Name: 
// Module Name: keyboard_tb
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


module keyboard_tb;
// Inputs
	reg clk;
	reg reset;
	reg [3:0] row;

	// Outputs
	wire [3:0] col;
	wire [3:0] key_val;
	wire [1:0] LED;
    wire  key_en;
	// Instantiate the Unit Under Test (UUT)
	keyboard uut (
		.clk(clk), 
		.reset(reset), 
		.row(row), 
		.col(col), 
		.key_val(key_val),
		.LED(LED),
		.key_en(key_en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		row = 4'b1111;
        #30 reset = 1;
		// Wait 100 ns for global reset to finish
		#40  row = 4'b1110 ;
		#60  row = 4'b1111;
		#20    row = 4'b1110;
		#100  row = 4'b1101  ;
        #100  row = 4'b1011 ;
        #100  row = 4'b0111  ;
		// Add stimulus here
		end
         always #5 clk <= ~clk;
	
endmodule
