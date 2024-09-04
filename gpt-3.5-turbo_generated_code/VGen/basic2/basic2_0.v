
// This is a module that implements an AND gate
module and_gate( 
    input a,      // First input
    input b,      // Second input
    output out    // Output
);

// Implementing the AND operation
assign out = a & b; // out is high if both a and b are high

endmodule