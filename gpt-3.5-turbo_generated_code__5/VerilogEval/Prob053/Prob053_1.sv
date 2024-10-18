
module TopModule (
    input clk,
    input in,
    output reg out
);

reg d_ff;

// XOR gate
assign out = in ^ d_ff;

// D flip-flop
always @(posedge clk) begin
    d_ff <= out;
end

endmodule