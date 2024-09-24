
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out,
    output wire out_n
);

    wire and1_out;  // Intermediate wire for first AND gate (a AND b)
    wire and2_out;  // Intermediate wire for second AND gate (c AND d)

    // First layer: Two AND gates
    and and1 (and1_out, a, b);  // AND gate 1
    and and2 (and2_out, c, d);   // AND gate 2

    // Second layer: Or gate
    or or1 (out, and1_out, and2_out);  // OR gate

    // Inverted output
    not not1 (out_n, out);  // Invert the output

endmodule