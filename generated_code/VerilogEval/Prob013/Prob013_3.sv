
module TopModule (
    input wire in1,  // First input
    input wire in2,  // Second input
    output wire out  // Output
);

// Implementing NOR gate logic
assign out = ~(in1 | in2);

endmodule