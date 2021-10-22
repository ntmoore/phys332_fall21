module implement_clocks(
    input CLK100MHZ,
    output [7:8] JA,
    output [1:0] LED,
    );
    
    wire CLK_100HZ;    
    
    // the brigntnesses on these two pins should differ
    assign LED[0] = 1'b1;
    assign LED[1] = CLK_100HZ;
             
  // sending oth clocks to the PMOD pins on the lower JA header
    assign JA[7] = CLK_100MHZ;
    assign JA[8] = CLK_100HZ;

    create_100HZ_clock  gate0(CLK100MHZ, CLK_100HZ);

endmodule

module create_100HZ_clock(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK100HZ
    );
    
    // 100MHZ is 10ns cycles.  If I want 100HZ output, I need to count 100M/100 = 1e6 cycles = 1_000_000 cycles
    // 2^20 = 1_048_576
    reg [19:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr==499_999) begin
            outgoing_CLK100HZ <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==999_999) begin
            outgoing_CLK100HZ <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end         
    end
endmodule
