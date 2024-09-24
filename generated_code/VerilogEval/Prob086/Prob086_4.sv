
module TopModule (
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] lfsr_state;

always @(posedge clk) begin
    if (reset) begin
        lfsr_state <= 5'b1;
    end else begin
        lfsr_state <= {lfsr_state[3] ^ lfsr_state[4], lfsr_state[4:1]};
    end
end

assign q = lfsr_state;

endmodule