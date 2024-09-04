
module TopModule (
    input  wire clk,  // Clock input
    input  wire in,   // Input signal
    output reg out    // Output signal
);
    // An internal wire to hold the output of the XOR gate
    wire xor_out;

    // XOR gate taking 'in' and 'out' as inputs
    assign xor_out = in ^ out;

    // D flip-flop triggered on the positive edge of clk
    always @(posedge clk) begin
        out <= xor_out; // D flip-flop takes input from XOR output
    end

endmodule