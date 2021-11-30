`timescale 1ns / 1ps

// this is the top level module
module implement_count_up_and_display(
    input CLK100MHZ,
    input BTNL, // left button on Nexys4DDR
    input BTNR, // right button
    output [8:0] LED,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
    );

    // set up the 1HZ clock
    wire CLK_1HZ;
    clk_1Hz_1000ms gate1( CLK100MHZ, CLK_1HZ);
    

    // set up a counter
    wire [31:0] sum;
    wire button, clear;
    assign button = BTNL;
    assign clear = BTNR;
    count_button_push gate2( CLK100MHZ, button, clear, sum[31:0]);
    
    assign LED[7:0] = sum[7:0];
    assign LED[8] = CLK_1HZ;
    
    // dim the 7-segs with a kHz clock
    wire CLK_1kHz;
    clk_1kHz_1ms gate4( CLK100MHZ,CLK_1kHz);
    wire CLK_2kHz;
    clk_2kHz_500us gate5( CLK100MHZ,CLK_2kHz);
    wire CLK_4kHz;
    clk_4kHz_250us gate6( CLK100MHZ,CLK_4kHz);
    
    // set up the display
    wire [7:0] hot;
    assign hot[0] = ( ~CLK_1kHz & ~CLK_2kHz & ~CLK_4kHz);  // remember, ACTIVE LOW    
    assign hot[1] = ( ~CLK_1kHz & ~CLK_2kHz &  CLK_4kHz);    
    assign hot[2] = ( ~CLK_1kHz &  CLK_2kHz & ~CLK_4kHz);
    assign hot[3] = ( ~CLK_1kHz &  CLK_2kHz &  CLK_4kHz);    
    assign hot[4] = (  CLK_1kHz & ~CLK_2kHz & ~CLK_4kHz);    
    assign hot[5] = (  CLK_1kHz & ~CLK_2kHz &  CLK_4kHz);
    assign hot[6] = (  CLK_1kHz &  CLK_2kHz & ~CLK_4kHz);    
    assign hot[7] = (  CLK_1kHz &  CLK_2kHz &  CLK_4kHz);
    assign AN[7:0] = ~ hot[7:0];  // remember, ACTIVE LOW 
    
    assign DP = 1'b1;
    wire CA0,CB0,CC0,CD0,CE0,CF0,CG0, CA1,CB1,CC1,CD1,CE1,CF1,CG1;
    wire CA2,CB2,CC2,CD2,CE2,CF2,CG2, CA3,CB3,CC3,CD3,CE3,CF3,CG3;
    wire CA4,CB4,CC4,CD4,CE4,CF4,CG4, CA5,CB5,CC5,CD5,CE5,CF5,CG5;
    wire CA6,CB6,CC6,CD6,CE6,CF6,CG6, CA7,CB7,CC7,CD7,CE7,CF7,CG7;

    // split the binary number via hex representation
    generate_7seg_bits digit0( sum[3],  sum[2],  sum[1],  sum[0], CA0,CB0,CC0,CD0,CE0,CF0,CG0);
    generate_7seg_bits digit1( sum[7],  sum[6],  sum[5],  sum[4], CA1,CB1,CC1,CD1,CE1,CF1,CG1);
    generate_7seg_bits digit2(sum[11], sum[10],  sum[9],  sum[8], CA2,CB2,CC2,CD2,CE2,CF2,CG2);
    generate_7seg_bits digit3(sum[15], sum[14], sum[13], sum[12], CA3,CB3,CC3,CD3,CE3,CF3,CG3);
    generate_7seg_bits digit4(sum[19], sum[18], sum[17], sum[16], CA4,CB4,CC4,CD4,CE4,CF4,CG4);
    generate_7seg_bits digit5(sum[23], sum[22], sum[21], sum[20], CA5,CB5,CC5,CD5,CE5,CF5,CG5);
    generate_7seg_bits digit6(sum[27], sum[26], sum[25], sum[24], CA6,CB6,CC6,CD6,CE6,CF6,CG6);
    generate_7seg_bits digit7(sum[31], sum[30], sum[29], sum[28], CA7,CB7,CC7,CD7,CE7,CF7,CG7);
    
    // implicit multiplexer
    assign CA = hot[0] & CA0 | hot[1] & CA1 | hot[2] & CA2 | hot[3] & CA3 | hot[4] & CA4 | hot[5] & CA5 | hot[6] & CA6 | hot[7] & CA7;
    assign CB = hot[0] & CB0 | hot[1] & CB1 | hot[2] & CB2 | hot[3] & CB3 | hot[4] & CB4 | hot[5] & CB5 | hot[6] & CB6 | hot[7] & CB7;
    assign CC = hot[0] & CC0 | hot[1] & CC1 | hot[2] & CC2 | hot[3] & CC3 | hot[4] & CC4 | hot[5] & CC5 | hot[6] & CC6 | hot[7] & CC7;
    assign CD = hot[0] & CD0 | hot[1] & CD1 | hot[2] & CD2 | hot[3] & CD3 | hot[4] & CD4 | hot[5] & CD5 | hot[6] & CD6 | hot[7] & CD7;
    assign CE = hot[0] & CE0 | hot[1] & CE1 | hot[2] & CE2 | hot[3] & CE3 | hot[4] & CE4 | hot[5] & CE5 | hot[6] & CE6 | hot[7] & CE7;
    assign CF = hot[0] & CF0 | hot[1] & CF1 | hot[2] & CF2 | hot[3] & CF3 | hot[4] & CF4 | hot[5] & CF5 | hot[6] & CF6 | hot[7] & CF7;
    assign CG = hot[0] & CG0 | hot[1] & CG1 | hot[2] & CG2 | hot[3] & CG3 | hot[4] & CG4 | hot[5] & CG5 | hot[6] & CG6 | hot[7] & CG7;
    
endmodule

// input is a clock
//output is the number of clock ticks received
module     count_button_push( 
    input CLK_IN, 
    input button,
    input clear,
    output reg [31:0] sum_out
    );
    
    always @(posedge CLK_IN) begin
        if ( clear==1 ) begin
            sum_out <= 0;
        end else if (button==1 && clear==0) begin
            sum_out <= sum_out + 32'b0000_0000_0000_0000_0000_0000_0000_0001;
        end        
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
