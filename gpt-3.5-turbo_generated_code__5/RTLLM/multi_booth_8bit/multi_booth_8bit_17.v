
module multi_booth_8bit (
    input clk,
    input reset,
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] p,
    output reg rdy
);

reg [15:0] multiplier, multiplicand;
reg [4:0] ctr;

always @(posedge clk or posedge reset)
begin
    if (reset) begin
        multiplier <= {{8{a[7]}}, a};
        multiplicand <= {{8{b[7]}}, b};
        ctr <= 0;
        p <= 0;
        rdy <= 0;
    end
    else begin
        if (ctr < 16) begin
            multiplicand <= {multiplicand[14:0], 1'b0}; // left-shift multiplicand by 1
            if (multiplier[ctr] == 1) begin
                p <= p + multiplicand;
            end
            ctr <= ctr + 1;
            if (ctr == 16) begin
                rdy <= 1;
            end
        end
    end
end

endmodule