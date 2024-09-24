
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire q
);

    assign q = (b & c & d) |             // Case: a=1, b=1, c=1, d=1
               (!a & !b & !c & !d) |     // Case: a=0, b=0, c=0, d=0
               (!a & d) |                 // Case: a=0, b=0, c=0, d=1
               (b & !c & !d) |            // Case: a=0, b=1, c=0, d=0
               (!a & c & d) |             // Case: a=0, b=0, c=1, d=1
               (a & !b & c & !d) |        // Case: a=1, b=0, c=1, d=0
               (a & b & !c & d);          // Case: a=1, b=1, c=0, d=1

endmodule