
module TopModule (
    input  wire in1,
    input  wire in2,
    output wire out
);
    
    // Intermediate signal to hold the inverted input
    wire in2_not;

    // Invert in2
    assign in2_not = ~in2;

    // AND gate with in1 and inverted in2
    assign out = in1 & in2_not;

endmodule