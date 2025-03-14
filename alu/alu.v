`timescale 1ns/1ps

module alu(
	input clk,
	input rst,
	input [31:0] A,B,
	input [2:0] alu_ctrl,
	output reg [31:0] result
	);
parameter add = 3'b000, sub = 3'b001, annd = 3'b010, orr = 3'b011, nott = 3'b100;
always @(posedge clk)
	begin
		if(rst)
			result<=0;
		else
		begin
			case(alu_ctrl)
			add: result = A+B;
			sub: result = A-B;
			annd: result = A&B;
			orr: result = A|B;
			nott: result = ~A ;
			default:result = 0;
			endcase
		end

	end
endmodule
	
