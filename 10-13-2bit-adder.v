`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// this is a 2bit + 2bit adder for Nexys4 DDR board 
// code is initially broken.  See attached photos for intended design

module test_two_bit_adder(    
    input [3:0] SW,
    output [2:0] LED);
    
    two_bit_adder add_2(SW[3:2], SW[1:0], LED[2:0]);
    
endmodule
        
module two_bit_adder(
    input [1:0] a,
    input [1:0 b,
    output [2:0] sum
    );

    wire a1, a0, b1, b0;
    assign a[1] = a1;           
    assign a[0] = a0; 
    assign b[1] = b1;           
    assign b[0] = b0; 
    
    wire s1, s0, cout;
    assign sum[2] = cout;           
    assign sum[1] = s1; 
    assign sum[0] = s0;           
   
    wire c_mid; // intermedite wire
        
    fulladder add0(a0, b0, 0, c_mid, s0);
    fulladder add1(a1, b1, c_mid, cout, s1);
        
endmodule 

module fulladder(
    input a,
    input b,
    input c_in,
    output c_out
    output sum
    );
    assign c_out = (a & b) | (a & c_in) | (b & c_in);
    assign sum = (~a & ~b & c) | (~a & b & ~c) | (a & b & c) | (a & ~b & ~c);
endmodule
