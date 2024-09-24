
module TopModule (
    input wire a,    // Input a
    input wire b,    // Input b
    output wire out  // Output out
);

// Implementing NOR logic
assign out = ~(a | b); // NOR gate implementation

endmodule