
module TopModule (
    input  clk,
    input  reset,
    output reg [31:0] q
);

    // Define the feedback logic for the Galois LFSR
    always @(posedge clk) begin
        if (reset) begin
            // On reset, set output to 32'h1
            q <= 32'h1;
        end else begin
            // Shift left and apply the feedback based on the tap positions
            q[31:1] <= q[30:0]; // Shift left
            q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0]; // Feedback from taps at positions 32, 22, 2, and 1
        end
    end
endmodule