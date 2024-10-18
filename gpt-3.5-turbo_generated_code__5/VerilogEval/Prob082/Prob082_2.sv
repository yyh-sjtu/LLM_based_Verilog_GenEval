
module TopModule (
    input  clk,
    input  reset,
    output reg [31:0] q
);

reg [31:0] lfsr_reg;

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
        lfsr_reg <= 32'h1;
    end else begin
        q <= lfsr_reg;
        lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0]};
    end
end

endmodule