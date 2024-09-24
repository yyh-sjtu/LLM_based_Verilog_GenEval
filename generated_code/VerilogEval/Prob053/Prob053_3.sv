
module TopModule (
    input  wire clk,    // Clock input
    input  wire in,     // Input signal
    output reg  out     // Output signal
);

    // Internal signal for the XOR output
    wire xor_out;

    // XOR gate implementation
    assign xor_out = in ^ out;

    // D Flip-Flop implementation
    always @(posedge clk) begin
        out <= xor_out;
    end

endmodule