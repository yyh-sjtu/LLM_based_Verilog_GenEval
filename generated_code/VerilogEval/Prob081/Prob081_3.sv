
module TopModule (
    input  wire p1a,
    input  wire p1b,
    input  wire p1c,
    input  wire p1d,
    input  wire p1e,
    input  wire p1f,
    input  wire p2a,
    input  wire p2b,
    input  wire p2c,
    input  wire p2d,
    output wire p1y,
    output wire p2y
);

// Internal wires for intermediate AND gate outputs
wire and1_out; // For the first 3-input AND
wire and2_out; // For the second 3-input AND
wire and3_out; // For the first 2-input AND
wire and4_out; // For the second 2-input AND

// Implementing the AND gates for p1y
assign and1_out = p1a & p1b & p1c; // AND gate 1: p1a & p1b & p1c
assign and2_out = p1d & p1e & p1f; // AND gate 2: p1d & p1e & p1f

// p1y is the OR of the outputs from the two 3-input AND gates
assign p1y = and1_out | and2_out; // OR gate: and1_out OR and2_out

// Implementing the AND gates for p2y
assign and3_out = p2a & p2b; // AND gate 3: p2a & p2b
assign and4_out = p2c & p2d; // AND gate 4: p2c & p2d

// p2y is the OR of the outputs from the two 2-input AND gates
assign p2y = and3_out | and4_out; // OR gate: and3_out OR and4_out

endmodule