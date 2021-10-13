`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// this is a 2bit + 2bit adder for Nexys4 DDR board 
// code is initially broken.  See attached photos for intended design

module example1(
    input [3:0] swt,
    output [2:0] led
    );
    wire a1, a0, b1, b0; // inputs
    wire s1, s0, cout; // outputs
    wire c_out0 // intermediate
    
    // global inputs
    assign a0 = swt[0];
    assign a1 = swt[1];
    assign b0 = swt[2];
    assign b1 = swt[3];
    
    // global outputs
    assign led[0] = s0;
    assign led[1] = s1;
    assign led[2] = cout;
    
    fulladder add0(a0,b0, 0, c_out0, s0);
    fulladder add1(a1,b1,c_out0, cout, s1);
        
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
