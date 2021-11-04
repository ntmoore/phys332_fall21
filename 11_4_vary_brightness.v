`timescale 1ns / 1ps

module dim_LED(
    input CLK100MHZ,
    input [3:0] SW,
    output [1:0] LED
    );
    
    assign LED[0]=1'b1;
    
    brightness gate0 (CLK100MHZ, LED[1],SW[3:0]);
    
endmodule

module brightness(
    input CLK,
    output reg brightness,
    input [3:0] in_b_value
    );
    reg [3:0] ctr=0;
    
    always @(posedge CLK) begin
        if(ctr==8'b0000) begin
            brightness <= 1'b1;
            ctr <= ctr+1;
        end else if(ctr==in_b_value) begin
            brightness <= 1'b0;
            ctr <= ctr+1;
// not needed because the counter will roll automatically
//        end else if(ctr==8'b1111) begin        
//            ctr <= 1'b0;
        end else begin
            ctr <= ctr+1;
        end
            
    end
    
endmodule
