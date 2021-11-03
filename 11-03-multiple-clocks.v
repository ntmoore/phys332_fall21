`timescale 1ns / 1ps

module clocks_11_03(
    output [7:0] LED,
    input CLK100MHZ
    );

  wire clk_0,clk_1,clk_2,clk_4;
  assign LED[0] = clk_0;
  assign LED[0] = clk_2;
  assign LED[0] = clk_3;
  assign LED[0] = clk_4;
  
  slow_clock_2x gate0(CLK100MHZ,clk_0);
  slow_clock_2x gate1(clk_0,clk_1);
  slow_clock_2x gate2(clk_1,clk_2);
  slow_clock_2x gate3(clk_2,clk_3);
  slow_clock_2x gate4(clk_3,clk_4);
	
endmodule

module slow_clock_2x( 
	input clk_in,
	output reg clk_out
	);
	
	reg int_ctr=0;
  
  always@(posedge clk_in) begin
    if(clk_out==1) begin
			clk_out <= 0;
    end else if(clk_out==0) begin
			clk_out <= 1;
		end 
	end
			
endmodule
