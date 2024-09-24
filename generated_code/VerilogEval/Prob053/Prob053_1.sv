
module TopModule (
    input clk,
    input in,
    output reg out
);

reg flop_out;

always @(posedge clk) begin
    flop_out <= in ^ out;
    out <= flop_out;
end

endmodule