
module TopModule (
    input clk,
    input d,
    output reg q
);

reg q_int;

always @(posedge clk) begin
    q_int <= d; // First flip-flop triggered on positive edge
end

always @(negedge clk) begin
    q <= q_int; // Second flip-flop triggered on negative edge, output updated
end

endmodule