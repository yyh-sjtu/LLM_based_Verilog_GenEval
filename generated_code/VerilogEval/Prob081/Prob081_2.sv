
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

    // Intermediate signals for the p1y output
    wire and1_out; // output from AND gate 1
    wire and2_out; // output from AND gate 2

    // AND gates for p1y output
    assign and1_out = p1a & p1b & p1c; // 3-input AND gate
    assign and2_out = p1d & p1e & p1f; // 3-input AND gate
    
    // OR gate for p1y output
    assign p1y = and1_out | and2_out; // OR of the two AND outputs

    // Intermediate signals for the p2y output
    wire and3_out; // output from AND gate 3
    wire and4_out; // output from AND gate 4

    // AND gates for p2y output
    assign and3_out = p2a & p2b; // 2-input AND gate
    assign and4_out = p2c & p2d; // 2-input AND gate
    
    // OR gate for p2y output
    assign p2y = and3_out | and4_out; // OR of the two AND outputs

endmodule