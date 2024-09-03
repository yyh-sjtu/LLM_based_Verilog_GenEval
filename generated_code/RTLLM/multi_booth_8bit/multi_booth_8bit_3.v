
module multi_booth_8bit(
    input wire clk,
    input wire reset,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [15:0] p,
    output reg rdy
);

reg [15:0] multiplicand;
reg [15:0] multiplier;
reg [4:0] ctr;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        multiplier <= {{8{a[7]}}, a};
        multiplicand <= {{8{b[7]}}, b};
        p <= 0;
        ctr <= 0;
        rdy <= 0;
    end
    else begin
        if (ctr < 16) begin
            multiplicand <= multiplicand << 1;
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