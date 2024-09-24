
module TopModule (
    input  p1a,
    input  p1b,
    input  p1c,
    input  p1d,
    input  p1e,
    input  p1f,
    input  p2a,
    input  p2b,
    input  p2c,
    input  p2d,
    output p1y,
    output p2y
);

    // Internal signals for the AND gates
    wire and1_out; // Output of the first 3-input AND gate
    wire and2_out; // Output of the second 3-input AND gate
    wire and3_out; // Output of the first 2-input AND gate
    wire and4_out; // Output of the second 2-input AND gate

    // 3-input AND gates
    assign and1_out = p1a & p1b & p1c; // AND gate for p1a, p1b, p1c
    assign and2_out = p1d & p1e & p1f; // AND gate for p1d, p1e, p1f

    // 2-input AND gates
    assign and3_out = p2a & p2b;       // AND gate for p2a, p2b
    assign and4_out = p2c & p2d;       // AND gate for p2c, p2d

    // OR gates for outputs
    assign p1y = and1_out | and2_out;  // OR gate for p1y
    assign p2y = and3_out | and4_out;  // OR gate for p2y

endmodule