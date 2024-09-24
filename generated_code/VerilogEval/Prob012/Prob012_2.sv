
module TopModule (
    input wire a,    // Input a
    input wire b,    // Input b
    output wire out  // Output out
);

    // Implementing XNOR gate
    assign out = ~(a ^ b);  // XNOR gate is equivalent to NOT of XOR

endmodule