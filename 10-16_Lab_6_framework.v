// This is a possible way to organize the modules for Lab 6.  
// Reminder, the idea is that your design will need to take in 
// 2x 4bit numbers, add them together, and then display the 
// result of the addition to a 7-segment digit.
`timescale 1ns / 1ps

module drive7seg(
    input [7:0] SW,
    output [7:0] AN,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP
    );
    
    wire a0, a1, a2, a3, b0, b1,  b2, b3;
    assign a0=SW[0];
    assign a1=SW[1];
    assign a2=SW[2];
    assign a3=SW[3];
    
    assign b0=SW[4];
    assign b1=SW[5];
    assign b2=SW[6];
    assign b3=SW[7];

    wire s3,s2,s1,s0, c_in, c_out;     
    add_4_bits fa(a3,a2,a1,a0, b3,b2,b1,b0, c_in, c_out, s3,s2,s1,s0);
    
    wire da,db,dc,dd,de,df,dg;
    generate_7seg_bits gen1(s3,s2,s1,s0, da,db,dc,dd,de,df,dg);
    
    //connect driver bits to the 7-seg LEDs
    // reminder, 7seg leds are active LOW
    assign CA=da;
    assign CB=db;
    assign CC=dc;
    assign CD=dd;
    assign CE=de;
    assign CF=df;
    assign CG=dg;
     
    //Which digit are you driving? only #0, reminder, active LOW
    assign AN[7:1]=7'b111_1111;
    assign AN[0]=1'b0;

endmodule

// pulling this module from previous class discussion 
//  https://github.com/ntmoore/phys332_fall21/blob/main/10-13-2bit-adder.v
module fulladder(
    input a,
    input b, 
    input c_in,
    output c_out,
    output sum
    );
    assign c_out = (a & b) | (a & c_in) | (b & c_in);
    assign sum = (~a & ~b & c) | (~a & b & ~c) | (a & b & c) | (a & ~b & ~c);
endmodule

// you need to create the code that drives this.  I suggest you check the class example 
// at https://github.com/ntmoore/phys332_fall21/blob/main/10-13-2bit-adder.v 
// operation is binary add:
//          a3  a2  a1  a0 
//      +   b3  b2  b1  b0 
//      +   0   0   0   c_in 
// = c_out  s3  s2  s1  s0
//
module add_4_bits fa(
    input a3,
    input a2,
    input a1,
    input a0, 
    input b3,
    input b2,
    input b1,
    input b0, 
    input c_in, 
    output c_out, 
    output s3,
    output s2,
    output s1,
    output s0);

endmodule
    
// you need to create the code that drives this.  
// Input is the 4-bit number s3 s2 s1 a0
// output is the 7-segment display digits da,db,dc,dd,de,df,dg
// reminder, display digits are active-LOW
// one approach is to generate 7 karnaugh maps
module generate_7seg_bits gen1(
    input s3,
    input s2,
    input s1,
    input s0, 
    output da,
    output db,
    output dc,
    output dd,
    output de,
    output df,
    output dg);

endmodule
