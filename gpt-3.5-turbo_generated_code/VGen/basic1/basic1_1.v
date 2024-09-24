
// This is a module that assigns the output to the input
module wire_assign(
    input wire in,    // Declare input
    output wire out   // Declare output
);

// Continuous assignment: out is assigned the value of in
assign out = in;

endmodule