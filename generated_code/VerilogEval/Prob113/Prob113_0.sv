
module TopModule (
    input  wire [3:0] x,  // 4-bit input
    output wire        f   // 1-bit output
);

    // Logic implementation based on the minimized expression
    assign f = (~x[2] & ~x[3]) | (x[2] & ~x[1]) | (x[2] & x[0]); // f = x2'x3' + x2x1' + x2x0

endmodule