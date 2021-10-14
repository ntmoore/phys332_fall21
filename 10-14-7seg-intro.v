// make a bitstream with this file.  Is AN active HIGH or active LOW?  
// What about the CA-CG bits?
`timescale 1ns / 1ps

module drive7seg(
    input [9:0] SW,
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
    
    assign CA=SW[0];
    assign CB=SW[1];
    assign CC=SW[2];
    assign CD=SW[3];
    assign CE=SW[4];
    assign CF=SW[5];
    assign CG=SW[6];
    assign DP=SW[7];
    
    assign AN[7:2]=6'b0;
    assign AN[1]=SW[8];
    assign AN[0]=SW[9];

endmodule
