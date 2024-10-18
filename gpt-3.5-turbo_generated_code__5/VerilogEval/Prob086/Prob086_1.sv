
module TopModule(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] lfsr;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        lfsr <= 5'b1; // Reset LFSR output to 1
    end else begin
        lfsr <= {lfsr[3]^lfsr[4], lfsr[4:1]}; // Galois LFSR with taps at bit positions 5 and 3
    end
end

assign q = lfsr;

endmodule