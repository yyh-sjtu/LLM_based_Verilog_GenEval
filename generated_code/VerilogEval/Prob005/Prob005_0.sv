
// TopModule implementation as a NOT gate
module TopModule (
    input wire in,   // Input signal
    output wire out  // Output signal (NOT of input)
);

// Implementing NOT gate functionality
assign out = ~in;

endmodule