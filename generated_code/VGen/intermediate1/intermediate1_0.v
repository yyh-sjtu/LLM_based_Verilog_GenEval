module implementation
module half_adder(
    input a, // First input
    input b, // Second input
    output sum, // Output sum
    output cout // Output carry
);

    assign sum = a ^ b; // XOR operation for sum
    assign cout = a & b; // AND operation for carry

endmodule

