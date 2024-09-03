module half_adder(
    input a, b, // input signals
    output sum, // output sum
    output cout // output carry
);

    assign sum = a ^ b; // XOR gate for sum
    assign cout = a & b; // AND gate for carry

endmodule

