
module TopModule (
    input wire x,
    input wire y,
    output wire z
);
    // Internal signal to hold the result of the XOR operation
    wire xor_result;

    // Compute the XOR of x and y
    assign xor_result = x ^ y;

    // Compute z = (x ^ y) & x
    assign z = xor_result & x;

endmodule