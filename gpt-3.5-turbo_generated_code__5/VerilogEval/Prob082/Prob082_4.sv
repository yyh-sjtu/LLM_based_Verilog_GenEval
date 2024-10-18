
module TopModule (
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] lfsr_state;

always @(posedge clk) begin
    if (reset) begin
        lfsr_state <= 32'h1;
    end else begin
        lfsr_state <= {lfsr_state[31] ^ lfsr_state[22] ^ lfsr_state[2] ^ lfsr_state[1], lfsr_state[31:1]};
    end
end

assign q = lfsr_state;

endmodule