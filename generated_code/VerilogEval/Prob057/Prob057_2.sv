
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    assign out = (~a & ~b & d) |    // m0, m1
                 (~a & c) |        // m4
                 (a & b & ~c & ~d) | // m8
                 (a & ~b & c & d); // m7

endmodule