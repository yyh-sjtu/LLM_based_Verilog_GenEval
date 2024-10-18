
module multi_booth_8bit (
    input clk,
    input reset,
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] p,
    output reg rdy
);

reg [7:0] multiplier;
reg [7:0] multiplicand;
reg [4:0] ctr;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        multiplier <= {8{a[7]} , a};
        multiplicand <= {8{b[7]} , b};
        ctr <= 0;
        p <= 0;
        rdy <= 0;
    end else begin
        if (ctr < 16) begin
            multiplicand <= multiplicand << 1; // Shift multiplicand left
            if (multiplier[ctr] == 1) begin
                p <= p + multiplicand; // Accumulate multiplicant
            end
            ctr <= ctr + 1; // Increment counter
        end else begin // Multiplication operation completed
            rdy <= 1; // Set ready signal
        end
    end
end

endmodule