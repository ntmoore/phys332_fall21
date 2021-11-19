//module implement_clocks(
//    input CLK100MHZ,
//    output [7:9] JA,
//    output [2:0] LED,
//    );
    
//    wire CLK_100HZ;    
    
//    // the brigntnesses on these two pins should differ
//    assign LED[0] = 1'b1;
//    assign LED[1] = CLK_50MHZ;
//    assign LED[2] = CLK_1kHZ;
             
//  // sending oth clocks to the PMOD pins on the lower JA header
//    assign JA[7] = CLK_50MHZ;
//    assign JA[8] = CLK_1kHZ;
//    assign JA[9] = 1'b1;
    
//    clk_50MHz_20ns  gate0(CLK100MHZ, CLK_50MHZ);
//    clk_1kHz_ims    gate1(CLK100MHZ, CLK_1kHZ);

//endmodule

module clk_50MHz_20ns(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK_50MHz_20ns
    );
    
    // 100MHZ is 10ns cycles.  
    // I want 50MHz output, 20ns cycles
    
    // for this very simple counter (clock divider), the output can also be the state bit.
    always @ (posedge incoming_CLK100MHZ) begin
        if(outgoing_CLK_50MHz_20ns==1) begin
            outgoing_CLK_50MHz_20ns <= 1'b0;
        end else begin
            outgoing_CLK_50MHz_20ns <= 1'b1;
        end         
    end
endmodule

//module clk_10MHz_100ns(
//    input incoming_CLK100MHZ,
//    output reg outgoing_CLK
//    );
    
//    always @ (posedge incoming_CLK100MHZ) begin
    
//    end
//endmodule

//module clk_1MHz_1us(
//    input incoming_CLK100MHZ,
//    output reg outgoing_CLK
//    );
    
//    always @ (posedge incoming_CLK100MHZ) begin
    
//    end
//endmodule

//module clk_100kHz_10us(
//    input incoming_CLK100MHZ,
//    output reg outgoing_CLK
//    );
    
//    always @ (posedge incoming_CLK100MHZ) begin
    
//    end
//endmodule

//module clk_10kHz_100us(
//    input incoming_CLK100MHZ,
//    output reg outgoing_CLK
//    );
    
//    always @ (posedge incoming_CLK100MHZ) begin
    
//    end
//endmodule

// creates 10 kHz clock from a 100 MHz clock 
// 10 kHz clock has a period of 0.0001 seconds, which is equal to 0.1ms
// 100 MHz / 10000 Hz = 100 * 10^6 / 10000 = 10,000 cycles
// log_2(10,000) = 13.28, so 14 bits are needed for the counter
module clk_10kHz_1ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
   
    reg[13:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if (ctr == 4_999) begin
            outgoing_CLK <= 1'b1;
            ctr <= ctr + 1;            
        end else if (ctr == 9_999) begin
            outgoing_CLK <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule

// creates 1000 Hz clock from a 100 MHz clock 
// 1000 Hz clock has a period of 0.001 seconds, which is equal to 1ms
// 100 MHz / 1000 Hz = 100 * 10^6 / 1000 = 100,000 cycles
// log_2(100,000) = 16.61, so 17 bits are needed for the counter
module clk_1kHz_1ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
   
    reg[16:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if (ctr == 49_999) begin
            outgoing_CLK <= 1'b1;
            ctr <= ctr + 1;            
        end else if (ctr == 99_999) begin
            outgoing_CLK <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule
    
// creates 100 Hz clock from a 100 MHz clock 
// 100 Hz clock has a period of 0.01 seconds, which is equal to 10ms
// 100 MHz / 100 Hz = 100 * 10^6 / 100 = 1,000,000 cycles
// log_2(1,000,000) = 19.93, so 20 bits are needed for the counter
module clk_100Hz_10ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    reg[19:0] ctr=0;
    
    always @ (posedge incoming_CLK100MHZ) begin       
        if (ctr == 499_999) begin
            outgoing_CLK <= 1'b1;
            ctr <= ctr + 1;            
            end else if (ctr == 999_999) begin
            outgoing_CLK <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule

module clk_10Hz_100ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    // creates 10HZ clock from a 100MHZ clock
    // 10HZ clock has a period of 0.1 second = 100ms
    // 100MHz / 10Hz => (100 * (1000) * (1000)) / 10 = 10,000,000 cycles
    // log2(10,000,000) = 23.2, so 24 bits needed for counter
    reg [23:0] ctr;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if (ctr == 4999999) begin
            outgoing_CLK <= 1'b1;
            ctr <= ctr + 1;            
        end else if (ctr == 9999999) begin
            outgoing_CLK <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule

module clk_1Hz_1000ms(
    input incoming_CLK100MHZ,
    output reg outgoing_CLK
    );
    
    // creates 1HZ clock from a 100MHZ clock
    // 1HZ clock has a period of 1 second = 1000ms
    // 100MHz is 100,000,000 cycles
    // log2(10,0000,000) = 26.6, so 27 bits needed for counter
    reg[26:0] ctr;
    
    always @ (posedge incoming_CLK100MHZ) begin
        if (ctr == 49_999_999) begin
            outgoing_CLK <= 1'b1;
            ctr <= ctr + 1;            
        end
        else if (ctr == 99_999_999) begin
            outgoing_CLK <= 1'b0;
            ctr <= 0;
        end
        else begin
            ctr <= ctr + 1;
        end
    end
endmodule
