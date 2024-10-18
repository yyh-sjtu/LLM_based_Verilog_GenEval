
module TopModule (
    input clk,
    input reset,
    output [31:0] q
);

reg [31:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 32'h1;
    end else begin
        state <= {state[30:0], state[31] ^ state[29] ^ state[19] ^ state[1]};
    end
end

assign q = state;

endmodule