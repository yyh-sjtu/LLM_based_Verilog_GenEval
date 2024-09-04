
module TopModule (
    input wire in,  // 1-bit input
    output wire out // 1-bit output
);

    // Implementing the NOT gate
    assign out = ~in;

endmodule