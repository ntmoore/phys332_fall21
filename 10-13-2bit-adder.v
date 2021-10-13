`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// this is a 2bit + 2bit adder for Nexys4 DDR board 
// code is initially broken.  See attached photos for intended design

module example1(
    //Need to declare four switches
    input [3:0] SW,
    output [2:0] LED
    );
    wire a1, a0, b1, b0;
    wire s1, s0, cout;
    wire c_mid; // intermedite wire
    
    // global inputs
    assign a0 = SW[0];
    assign a1 = SW[1];
    assign b0 = SW[2];
    assign b1 = SW[3];
    
    // global outputs
    assign LED[0] = s0;
    assign LED[1] = s1;
    assign LED[2] = cout;
    
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
