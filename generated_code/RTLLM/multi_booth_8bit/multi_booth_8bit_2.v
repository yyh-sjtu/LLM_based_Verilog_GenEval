
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

always @(posedge clk or posedge reset) begin
    if (reset) begin
        multiplicand <= {{8{a[7]}}, a};
        multiplier <= {{8{b[7]}}, b};
        ctr <= 0;
        p <= 16'b0;
        rdy <= 0;
    end else begin
        if (ctr < 16) begin
            multiplicand <= {multiplicand[15], multiplicand[15:1]};
            if (multiplier[ctr]) begin
                p <= p + multiplicand;
            end
            ctr <= ctr + 1;
            if (ctr == 15) begin
                rdy <= 1;
            end
        end
    end
end

endmodule