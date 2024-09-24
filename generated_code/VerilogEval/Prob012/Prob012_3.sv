
module TopModule (
    input a,      // input signal a
    input b,      // input signal b
    output out    // output signal out
);

// Implementing the XNOR logic
assign out = ~(a ^ b); // XNOR logic: out is high when a and b are the same (both 0 or both 1)

endmodule