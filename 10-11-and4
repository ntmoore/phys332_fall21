`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 

module example1(
    input [3:0] swt,
    output [1:0] led
    );
    wire a_in, b_in, c_in, d_in;
    wire c1_out, c2_out, c3_out;
    assign a_in = swt[0];
    assign b_in = swt[1];
    assign c_in = swt[2];
    assign d_in = swt[3];
    assign led[0] = c3_out;
    
    and2 g1(a_in, b_in, c1_out);
    and2 g2(c_in, d_in, c2_out);
    and2 g3(c1_out, c2_out, c3_out);

    assign led[1] = swt[0] & swt[1] & swt[2] & swt[3];
    
endmodule 

module and2(
    input a,
    input b,
    output c
    );
    assign c = a & b;
endmodule
