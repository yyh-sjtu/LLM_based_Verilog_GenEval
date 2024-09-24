
module TopModule (
    input wire a,
    input wire b,
    output wire q
);

// Combinational logic for the output
assign q = a & b;  // Logical AND operation

endmodule