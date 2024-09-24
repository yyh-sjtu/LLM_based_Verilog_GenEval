
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire q
);

    assign q = (~a & ~b & ~c & ~d) |    // q = 1 when a=0, b=0, c=0, d=0
               (~a & ~b & c & d) |    // q = 1 when a=0, b=0, c=1, d=1
               (~a & b & c & ~d) |    // q = 1 when a=0, b=1, c=1, d=0
               (a & ~b & c & ~d) |    // q = 1 when a=1, b=0, c=1, d=0
               (a & b & ~c & d) |     // q = 1 when a=1, b=1, c=0, d=1
               (a & b & c & d);       // q = 1 when a=1, b=1, c=1, d=1

endmodule