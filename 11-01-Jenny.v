// How do you display multiple segments at once?  
// ask Jenny, 
//  https://www.youtube.com/watch?v=6WTdTwcmxyo
`timescale 1ns / 1ps

module write_to_7seg(
    input CLK100MHZ,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
    );
    
    wire [7:0] CAs;
    assign CA=CAs[7];
    assign CB=CAs[6];
    assign CC=CAs[5];
    assign CD=CAs[4];
    assign CE=CAs[3];
    assign CF=CAs[2];
    assign CG=CAs[1];
    assign DP=CAs[0];
    
    wire outgoing_CLK1KHZ;
    create_1KHZ_clock   gate2 (CLK100MHZ,outgoing_CLK1KHZ);
    
    // Note, if you run this with the 100MHZ clock, the display is messed up.  
    // Anode PNP transistors  (~35+ns to switch?) might not be fast enough to keep up?
    write_17    gate1 (outgoing_CLK1KHZ,AN,CAs);
//    write_17    gate1 (CLK100MHZ,AN,CAs);
    
endmodule

module write_17(input CLK,
    output reg [7:0] outAN,
    output reg [7:0] outCAs);

    reg [4:0] ctr=0;
    
    always @(posedge CLK) begin
        if(ctr==4'b0000) begin    
            // 8
            outAN <= 8'b1011_1111;  // 10's place 
            outCAs <= 8'b0000_0001; // number 1, B,C
        
        end else if(ctr==4'b0001) begin
            //6
            outAN <= 8'b1101_1111;  // 1's place
            outCAs <= 8'b1100_0001; // number 7, A,B,C
        
        end else if(ctr==4'b0010) begin
            //7
            outAN <= 8'b1110_1111;  // 1's place
            outCAs <= 8'b0001_1111; // number 7, A,B,C
        
        end else if(ctr==4'b0011) begin
            //5
            outAN <= 8'b1111_0111;  // 1's place
            outCAs <= 8'b0100_1001; // number 7, A,B,C
        
        end else if(ctr==4'b0100) begin
            //3
            outAN <= 8'b1111_1011;  // 1's place
            outCAs <= 8'b0000_1101; // number 7, A,B,C
        
        end else if(ctr==4'b0101) begin
            //0
            outAN <= 8'b1111_1101;  // 1's place
            outCAs <= 8'b0000_0011; // number 7, A,B,C
        
        end else if(ctr==4'b0110) begin
            //9
            outAN <= 8'b1111_1110;  // 1's place
            outCAs <= 8'b0000_1001; // number 7, A,B,C
        
        end else begin
            outAN <= 8'b1111_1111;
            outCAs <= 8'b1111_1111;
           
        end 
        
        // update the counter
        if(ctr==4'b01111) begin
            ctr <= 4'b0000;
        end else begin
            ctr <= ctr + 1;        
        end   
    end
    
endmodule

module create_1KHZ_clock(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK1KHZ
    );
    
    // 100MHZ is 10ns cycles.  If I want 1KHZ output, I need to count 100M/1K = 1e5 cycles = 100_000 cycles
    // 2^17 = 131_072
    reg [16:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr==49_999) begin
            outgoing_CLK1KHZ <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==99_999) begin
            outgoing_CLK1KHZ <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end         
    end
endmodule
