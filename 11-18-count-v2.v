`timescale 1ns / 1ps

// this is the top level module
module implement_count_up_and_display(
    input CLK100MHZ,
    output [8:0] LED,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
    );

    // set up the 1HZ clock
    wire CLK_1HZ;
    clk_1Hz_1000ms gate1( CLK100MHZ, CLK_1HZ);

    // set up a counter
    wire [7:0] sum;
    count_ticks gate2( CLK_1HZ, sum[7:0]);
    
    assign LED[7:0] = sum[7:0];
    assign LED[8] = CLK_1HZ;
    
    // dim the 7-segs with a kHz clock
    wire CLK_1kHz;
    clk_1kHz_1ms gate4( CLK100MHZ,CLK_1kHz);
    
    // set up the display
    assign AN[7:2] = 8'b1111_11; 
    assign AN[0] = ~CLK_1kHz;  // remember, ACTIVE LOW    
    assign AN[1] = CLK_1kHz;    
    assign DP = 1'b1;
    wire CA0,CB0,CC0,CD0,CE0,CF0,CG0, CA1,CB1,CC1,CD1,CE1,CF1,CG1;

    // split the binary number via hex representation
    generate_7seg_bits digit0(sum[3], sum[2], sum[1], sum[0], CA0,CB0,CC0,CD0,CE0,CF0,CG0);
    generate_7seg_bits digit1(sum[7], sum[6], sum[5], sum[4], CA1,CB1,CC1,CD1,CE1,CF1,CG1);

    // implicit multiplexer
    assign CA = CLK_1kHz & CA0 | ~ CLK_1kHz & CA1; 
    assign CB = CLK_1kHz & CB0 | ~ CLK_1kHz & CB1;
    assign CC = CLK_1kHz & CC0 | ~ CLK_1kHz & CC1;
    assign CD = CLK_1kHz & CD0 | ~ CLK_1kHz & CD1;
    assign CE = CLK_1kHz & CE0 | ~ CLK_1kHz & CE1;
    assign CF = CLK_1kHz & CF0 | ~ CLK_1kHz & CF1;
    assign CG = CLK_1kHz & CG0 | ~ CLK_1kHz & CG1; 

endmodule

// input is a clock
//output is the number of clock ticks received
module     count_ticks( 
    input CLK_IN, 
    output reg [7:0] sum_out
    );
    
    always @(posedge CLK_IN) begin
        sum_out <= sum_out + 8'b0000_0001;
    end
        
endmodule


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

//    active-LOW output, note the leading ~
    assign da = ~(zero | two | three | five | six | seven | eight | nine | ten | fourteen | fifteen );
    assign db = ~(zero | one | two | three | four | seven | eight | nine | ten | thirteen );
    assign dc = ~(zero | one | three | four | five | six | seven | eight | nine | ten | eleven | thirteen );
    assign dd = ~(zero | two | three | five | six | eight | eleven | twelve | thirteen | fourteen );
    assign de = ~(zero | two | six | eight | ten | eleven | twelve | thirteen | fourteen | fifteen );
    assign df = ~(zero | four | five | six | eight | nine | ten | eleven | fourteen | fifteen );
    assign dg = ~(two | three | four | five | six | eight | nine | ten | eleven | twelve | thirteen | fourteen | fifteen );
    
endmodule
