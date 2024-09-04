
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);
    // Internal signals
    wire a_not, b_not, c_not, d_not;
    wire term1, term2, term3;

    // Invert inputs
    assign a_not = ~a;
    assign b_not = ~b;
    assign c_not = ~c;
    assign d_not = ~d;

    // Generate each term of the output
    assign term1 = a_not & b;   // a'b
    assign term2 = c_not & d;   // c'd
    assign term3 = b_not & c;   // b'c

    // Final output
    assign out = term1 | term2 | term3; // out = a'b + c'd + b'c
endmodule