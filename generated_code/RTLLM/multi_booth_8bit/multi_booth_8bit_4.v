
module multi_booth_8bit (
    input clk, 
    input reset, 
    input [7:0] a, 
    input [7:0] b, 
    output reg [15:0] p, 
    output reg rdy
    );
    
    reg [15:0] multiplicand, multiplier;
    reg [4:0] ctr;
    reg [1:0] booth_bit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            multiplicand <= {{8{a[7]}}, a};
            multiplier <= {{8{b[7]}}, b};
            p <= 16'b0;
            rdy <= 0;
            ctr <= 0;
            booth_bit <= 2'b00;
        end else begin
            if (ctr < 16) begin
                if (booth_bit == 2'b01) begin // 1 to 1 transition
                    p <= p + multiplicand;
                end else if (booth_bit == 2'b10) begin // 0 to 1 transition
                    p <= p - multiplicand;
                end
                
                booth_bit <= multiplier[0:1]; // Get the current 2 bits of the multiplier
                
                multiplicand <= {multiplicand[14:0], multiplicand[15]}; // Left shift the multiplicand
                
                multiplier <= {multiplier[14:0], multiplier[15]}; // Right shift the multiplier
                
                ctr <= ctr + 1;
            end else begin
                rdy <= 1;
            end
        end
    end
endmodule