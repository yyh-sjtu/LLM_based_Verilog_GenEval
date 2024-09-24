
module TopModule (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    // Sequential logic for the flip-flop
    state <= (a && ~b) ? 1 : ((~a && b) ? 0 : state); // Update state based on conditions
    q <= state; // Output the current state, storing it in q
end

endmodule