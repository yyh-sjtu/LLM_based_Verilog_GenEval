module
module signed_adder (
    input [7:0] a,       // First 8-bit 2's complement number
    input [7:0] b,       // Second 8-bit 2's complement number
    output [7:0] s,      // Result of the addition
    output overflow      // Overflow flag
);

    reg signed [7:0] sum; // Variable to store the sum
    reg overflow;         // Variable to store the overflow flag

    // Perform the addition
    always @(*) begin
        sum = a + b; // Perform the addition of two 8-bit signed numbers
    end

    // Check for overflow
    always @(*) begin
        if ((a[7] == b[7]) && (a[7] != sum[7])) begin
            overflow = 1; // Set overflow flag if overflow occurs
        end else begin
            overflow = 0; // Clear overflow flag if no overflow occurs
        end
    end

    // Assign the sum to the output
    assign s = sum;

endmodule

