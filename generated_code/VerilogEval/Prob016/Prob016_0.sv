
module FullAdder (
    input  a,    // First input bit
    input  b,    // Second input bit
    input  cin,  // Carry input
    output sum,  // Sum output
    output cout  // Carry output
);
    assign sum = a ^ b ^ cin;      // Sum is the XOR of inputs
    assign cout = (a & b) | (cin & (a ^ b)); // Carry is generated
endmodule

module TopModule (
    input  [3:0] x,    // 4-bit input x
    input  [3:0] y,    // 4-bit input y
    output [4:0] sum   // 5-bit output including overflow
);
    wire [3:0] carry; // Intermediate carry signals

    // Instantiate Full Adders for each bit
    FullAdder FA0 (.a(x[0]), .b(y[0]), .cin(1'b0),       .sum(sum[0]), .cout(carry[0]));
    FullAdder FA1 (.a(x[1]), .b(y[1]), .cin(carry[0]),  .sum(sum[1]), .cout(carry[1]));
    FullAdder FA2 (.a(x[2]), .b(y[2]), .cin(carry[1]),  .sum(sum[2]), .cout(carry[2]));
    FullAdder FA3 (.a(x[3]), .b(y[3]), .cin(carry[2]),  .sum(sum[3]), .cout(carry[3]));

    // The final carry out is the MSB of the sum output (overflow bit)
    assign sum[4] = carry[3];

endmodule