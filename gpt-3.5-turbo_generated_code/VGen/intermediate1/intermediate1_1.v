module half_adder(
    input a, b,
    output cout, sum 
);

    assign sum = a ^ b; // XOR operation for sum
    assign cout = a & b; // AND operation for carry out

endmodule
