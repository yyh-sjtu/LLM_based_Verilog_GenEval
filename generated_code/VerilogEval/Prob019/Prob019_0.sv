
module TopModule (
    input wire in1,
    input wire in2,
    output wire out
);

// Internal wire to hold the inverted in2
wire not_in2;

// Invert in2
assign not_in2 = ~in2;

// AND gate with in1 and inverted in2
assign out = in1 & not_in2;

endmodule