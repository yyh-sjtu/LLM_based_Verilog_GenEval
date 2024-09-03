
module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    // Internal wires for computations
    wire [8:0] sum;
    wire carry_out;

    // Add the two inputs a and b
    assign {carry_out, sum} = a + b;

    // Output the sum to s
    assign s = sum[7:0];

    // Detect overflow by checking the sign bits of a, b and sum
    assign overflow = (a[7] & b[7] & !sum[7]) | (!a[7] & !b[7] & sum[7]);

endmodule