
module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_next, state_next;

always @(posedge clk) begin
    q <= q_next;
    state <= state_next;
end

always @* begin
    q_next = state;
    state_next = (state & ~a) | (b & state);
end

endmodule