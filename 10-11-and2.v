`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 

module example1(
    input [1:0] swt,
    output [1:0] led
    );
    wire a_in, b_in, c_out;
    assign a_in = swt[0];
    assign b_in = swt[1];
    assign led[0] = c_out;
    
    and2 g1(a_in, b_in, c_out);
    assign led[1] = swt[0] & swt[1];
    
endmodule 

module and2(
    input a,
    input b,
    output c
    );
    assign c = a & b;
endmodule
