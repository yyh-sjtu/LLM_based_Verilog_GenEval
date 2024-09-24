
module TopModule (
    input clk,
    input d,
    output reg q
);

reg q_rising_edge;
reg q_falling_edge;

always @(posedge clk) begin
    q_rising_edge <= d;
end

always @(negedge clk) begin
    q_falling_edge <= q_rising_edge;
end

assign q = q_falling_edge;

endmodule