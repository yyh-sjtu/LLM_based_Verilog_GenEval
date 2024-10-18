
module TopModule(
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// Initialize the flip-flop
always @(posedge clk) begin
    q <= state;
end

// Sequential logic
always @(posedge clk) begin
    if (a & ~b) begin
        state <= 0;
    end else if (a & b) begin
        state <= 1;
    end
end

endmodule