// What does a hardware wrapper for a module you'd like to test look like?  See below
// for a top-level modeule that serves to send signals to a 7-segment display driver (partically finished).
//
// This is a possible way to organize the modules for Lab 6.  
// Reminder, the idea is that your design will need to take in 
// 2x 4bit numbers, add them together, and then display the 
// result of the addition to a 7-segment digit.
`timescale 1ns / 1ps

module test_7seg(
    input [3:0] SW,
    output [7:0] AN,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP,
    output [3:0] LED // for debugging
    );

    // input 4-bit numbers to be added    
    wire n3,n2,n1,n0;
    assign n0=SW[0];
    assign n1=SW[1];
    assign n2=SW[2];
    assign n3=SW[3];
    
    assign LED[3:0]=SW[3:0]; //debug
    
    assign DP=1'b1; // active low, turn off
    
    wire da,db,dc,dd,de,df,dg;
    generate_7seg_bits gen1(n3,n2,n1,n0, da,db,dc,dd,de,df,dg);
    
    //connect driver bits to the 7-seg LEDs
    // reminder, 7seg leds are active LOW
    assign CA=~da;
    assign CB=~db;
    assign CC=~dc;
    assign CD=~dd;
    assign CE=~de;
    assign CF=~df;
    assign CG=~dg;
     
    //Which digit are you driving? only #0, reminder, active LOW
    assign AN[7:1]=7'b111_1111;
    assign AN[0]=1'b0;

endmodule

// you need to create the code that drives this.  
// Input is the 4-bit number s3 s2 s1 a0
// output is the 7-segment display digits da,db,dc,dd,de,df,dg
// reminder, display digits are active-LOW
// one approach is to generate 7 karnaugh maps
module generate_7seg_bits(
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

    // this would be more compact with a Karnaugh map for each segment da - dg
    // writing this way for readability 
    wire zero, one, two, three, four, five, six, seven, eight, nine;
    assign zero     = ~s3&~s2&~s1&~s0;
    assign one      = ~s3&~s2&~s1& s0;
    assign two      = ~s3&~s2& s1&~s0;
    assign three    = ~s3&~s2& s1& s0;
    assign four     = ~s3& s2&~s1&~s0;
    assign five     = ~s3& s2&~s1& s0;
    assign six      = ~s3& s2& s1&~s0;
    assign seven    = ~s3& s2& s1& s0;
    assign eight    =  s3&~s2&~s1&~s0;
    assign nine     =  s3&~s2&~s1& s0;
    assign ten      =  s3&~s2& s1&~s0; 
    assign eleven   =  s3&~s2& s1& s0; 
    assign twelve   =  s3& s2&~s1&~s0; 
    assign thirteen =  s3& s2&~s1& s0; 
    assign fourteen =  s3& s2& s1&~s0; 
    assign fifteen  =  s3& s2& s1& s0; 
    
    assign da = zero | two | three | five | six | seven | eight | nine | ten | fourteen | fifteen;
    assign db = 0;
    assign dc = 0;
    assign dd = 0;
    assign de = 0;
    assign df = 0;
    assign dg = 0;
    
endmodule
