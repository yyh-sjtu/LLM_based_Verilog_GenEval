
module TopModule (
    input   [7:0] in,    // 8-bit input
    output  [31:0] out   // 32-bit output
);

    // Sign-extend the 8-bit input to a 32-bit output
    assign out = { {24{in[7]}}, in }; // Concatenate 24 sign bits and the 8-bit input

endmodule