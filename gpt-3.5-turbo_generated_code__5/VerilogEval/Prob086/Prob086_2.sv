
module TopModule (
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] lfsr;

always @(posedge clk) begin
    if (reset) begin
        lfsr <= 5'b1;
    end else begin
        lfsr <= {lfsr[3]^lfsr[0], lfsr[4:1]};
    end
end

assign q = lfsr;

endmodule