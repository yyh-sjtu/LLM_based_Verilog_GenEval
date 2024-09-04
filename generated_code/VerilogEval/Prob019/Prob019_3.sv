
module TopModule (
    input wire in1,  // One-bit input
    input wire in2,  // One-bit input
    output wire out  // One-bit output
);

    // Declare the output as the AND result of in1 and the inverted in2
    assign out = in1 & ~in2;  // AND gate with inverted second input

endmodule