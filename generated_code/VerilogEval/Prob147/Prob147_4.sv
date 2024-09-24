
module TopModule(
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg flip_flop;

always @(posedge clk) begin
    state <= flip_flop;
    flip_flop <= a & ~b;
    q <= flip_flop;
end

endmodule