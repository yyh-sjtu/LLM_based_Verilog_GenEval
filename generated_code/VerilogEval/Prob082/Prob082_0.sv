
module TopModule (
    input  clk,
    input  reset,
    output reg [31:0] q
);

    // On reset, initialize q to 32'h1
    // Galois LFSR tap positions are 32, 22, 2, and 1
    // The feedback equation corresponds to:
    // new_bit = q[31] ^ q[21] ^ q[1] ^ q[0]
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Synchronous reset to 1
        end else begin
            // Calculate new bit (feedback)
            q <= {q[30:0], (q[31] ^ q[21] ^ q[1] ^ q[0])}; // Shift and insert the feedback bit
        end
    end
    
endmodule