
module TopModule (
    input wire in1,
    input wire in2,
    output wire out
);

// Implementing the NOR gate functionality
assign out = ~(in1 | in2); // out is the NOR of in1 and in2

endmodule