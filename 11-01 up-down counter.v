`timescale 1ns / 1ps

module updown_counter(
    input [1:0] SW,
    output [7:0] LED,
    input CLK100MHZ
    );
    
    make_clock_1hz gate0(CLK100MHZ,clk_1hz);

	implement_tic_tock_fsm gate1(clk_1hz,SW,LED);
	
endmodule



module implement_tic_tock_fsm(
	input clk_1hz,
	input [1:0] swch,
	output reg [7:0] leds
);

	always@(posedge clk_1hz) begin
		if(swch == 2'b00) begin
			// do nothing, implicitly
			//	leds <= leds;
		end else if(swch == 2'b01) begin
			// tick up 
			leds <= leds+1;
		end else if(swch == 2'b10) begin
			// tick down
			leds <= leds-1;
		end else if(swch == 2'b11) begin
			leds <= 8'b0000_0000;
		end
	end
endmodule


module make_clock_1hz( 
	input clk_50Mhz,
	output reg clk_1hz
	);
	
	// 2^26 = 67_108_864
	reg [25:0] int_ctr=0;
	
	always@(posedge clk_50Mhz) begin
		if(int_ctr==49_999_999) begin
			int_ctr <= 0;
			clk_1hz <= 0;
		end else if(int_ctr == 24_999_999) begin
			int_ctr <= int_ctr+1;
			clk_1hz <= 1;
		end else begin
			int_ctr <= int_ctr+1;
		end
	end
			
endmodule
