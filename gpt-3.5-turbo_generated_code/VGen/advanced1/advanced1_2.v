
module signed_adder(
    input [7:0] a,       // First signed 8-bit number
    input [7:0] b,       // Second signed 8-bit number
    output reg [7:0] s,  // Sum
    output reg overflow   // Overflow flag
);
    
    // Internal wire for the sum and carry out
    wire [8:0] sum; // 9 bits to capture carry out
    assign sum = {1'b0, a} + {1'b0, b}; // Extend to 9 bits for addition

    // Assign the sum to the output
    always @(*) begin
        s = sum[7:0]; // Capture the lower 8 bits for the result
        // Check for overflow
        overflow = (a[7] == b[7]) && (s[7] != a[7]);
    end

endmodule