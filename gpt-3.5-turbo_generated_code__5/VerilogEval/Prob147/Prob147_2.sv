
module TopModule (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg next_state;

always @(posedge clk) begin
    state <= next_state;
    q <= state;
end

always @* begin
    if (state == 0 && a == 0 && b == 1) begin
        next_state = 1;
    end else if (state == 1 && (a == 1 || b == 0)) begin
        next_state = 0;
    end
end

endmodule