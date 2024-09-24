
module TopModule (
    input clk,
    input in,
    output reg out
);

// Temporary wire to hold the result of the XOR operation
wire xor_out;

// Instantiate the XOR gate
assign xor_out = in ^ out;

// D Flip-Flop implementation
always @(posedge clk) begin
    out <= xor_out;
end

endmodule