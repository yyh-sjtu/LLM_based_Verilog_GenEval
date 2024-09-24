
module TopModule (
    input wire x,
    input wire y,
    output wire z
);

    // z is 1 when both inputs are either 0 or 1, and 0 otherwise
    assign z = (~x & ~y) | (x & y);

endmodule