
module TopModule (
    input  wire clk,
    input  wire reset,
    output reg [31:0] q
);

    // Galois LFSR feedback taps: 32, 22, 2, and 1
    wire feedback = q[31] ^ q[21] ^ q[1] ^ q[0]; // Tap positions 32, 22, 2, and 1

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset output to 32'h1 on synchronous reset
        end else begin
            // Shift register operation
            q <= {q[30:0], feedback}; // Shift the register and insert feedback bit
        end
    end

endmodule