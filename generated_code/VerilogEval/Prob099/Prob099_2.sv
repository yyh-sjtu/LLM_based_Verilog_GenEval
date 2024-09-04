
module TopModule (
    input  wire [6:0] y, // 7 bits
    input  wire w,
    output wire Y1,
    output wire Y3
);

    // Y2 corresponds to y[1]
    assign Y1 = (y[1] & w) | (y[5] & w); // Derived logic for Y2

    // Y4 corresponds to y[3]
    assign Y3 = y[2] | (y[1] & ~w); // Derived logic for Y4

endmodule