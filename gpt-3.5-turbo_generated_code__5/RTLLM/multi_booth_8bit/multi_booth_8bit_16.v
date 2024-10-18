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
    if (reset == 1'b1) begin
        multiplier <= {{8{a[7]}}, a};
        multiplicand <= {{8{b[7]}}, b};
        p <= 16'b0;
        rdy <= 1'b0;
        ctr <= 5'd0;
    end
    else begin
        if (ctr < 16) begin
            multiplicand <= {multiplicand[14:0], multiplicand[15]};
            if (multiplier[ctr] == 1'b1) begin
                p <= p + multiplicand;
            end
            ctr <= ctr + 1;
        end
        else begin
            rdy <= 1'b1;
        end
    end
end

endmodule

