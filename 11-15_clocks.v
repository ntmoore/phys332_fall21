module implement_clocks(
    input CLK100MHZ,
    output [6:8] JA,
    output [2:0] LED,
    );
    
    wire CLK_100HZ;    
    
    // the brigntnesses on these two pins should differ
    assign LED[0] = 1'b1;
    assign LED[1] = CLK_50MHZ;
    assign LED[2] = CLK_1kHZ;
             
  // sending oth clocks to the PMOD pins on the lower JA header
    assign JA[7] = CLK_50MHZ;
    assign JA[8] = CLK_1kHZ;

    clk_50MHz_20ns  gate0(CLK100MHZ, CLK_50MHZ);
    clk_1kHz_ims    gate1(CLK100MHZ, CLK_1kHZ);

endmodule

module clk_50MHz_20ns(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK_50MHz_20ns
    );
    
    // 100MHZ is 10ns cycles.  
    // I want 50MHz output, 20ns cycles
    //
    reg [2:0] ctr=0; //????
    
    // is this correct?  Doesn't seem quite right
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr==1) begin
            outgoing_CLK100HZ <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==2) begin
            outgoing_CLK100HZ <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end         
    end
endmodule

module clk_1kHz_ims(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK_1kHz_1ms
    );
    
    // 100MHZ is 10ns cycles.  
    // I want 1kHz output, 1ms cycles
    //
    reg [30:0] ctr=0; // ???
    
    // is this correct?  Doesn't seem quite right
    always @ (posedge incoming_CLK100MHZ) begin
        if(ctr==49_999) begin
            outgoing_CLK100HZ <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==99_999) begin
            outgoing_CLK100HZ <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end         
    end

module clk_10MHz_100ns(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_1MHz_1us(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_100kHz_10us(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_10kHz_100us(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_1kHz_1ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule
    
module clk_100Hz_10ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_10Hz_100ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule

module clk_1Hz_1000ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    always @ (posedge incoming_CLK100MHZ) begin
    
    end
endmodule
