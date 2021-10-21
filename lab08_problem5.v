// This 7-segment display driver can be useful for Lab 8, problem 5
//
// Input is the 4-bit number s3 s2 s1 a0
// Output is the (active-HIGH) 7-segment display digits da,db,dc,dd,de,df,dg
// reminder, Nexys4DDR display digits are active-LOW, so you'll need to invert them at some point
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
    assign db = zero | one | two | three | four | seven | eight | nine | ten | thirteen;
    assign dc = zero | one | three | four | five | six | seven | eight | nine | ten | eleven | thirteen ;
    assign dd = zero | two | three | five | six | eight | eleven | twelve | thirteen | fourteen ;
    assign de = zero | two | six | eight | ten | eleven | twelve | thirteen | fourteen | fifteen ;
    assign df = zero | four | five | six | eight | nine | ten | eleven | fourteen | fifteen ;
    assign dg = two | three | four | five | six | eight | nine | ten | eleven | twelve | thirteen | fourteen | fifteen ;
    
endmodule





// Here's an example wrapper for the module above that should work on a Nexys4DDR board
module drive7seg(
    input [3:0] SW,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP,
    output [7:0] AN
);

    assign DP=1'b1; // active low, turn off

    generate_7seg_bits gen1(SW[3], SW[2], SW[1], SW[0], ~CA, ~CB, ~CC, ~CD, ~CE, ~CF, ~CG);
    
    //Which digit are you driving? only #0, reminder, active LOW
    assign AN[7:1]=7'b111_1111;
    assign AN[0]=1'b0;

endmodule
