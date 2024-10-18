
module TopModule (
    input clk,
    input in,
    output reg out
);

reg d;
wire xor_input;

// XOR gate
assign xor_input = in ^ out;

// D flip-flop
always @(posedge clk) begin
    d <= xor_input;
    out <= d;
end

endmodule