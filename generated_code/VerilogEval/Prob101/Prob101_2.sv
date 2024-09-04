
q = (a == 0) ? (b | (c & d)) : b;
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire q
);
    assign q = (a == 0) ? (b | (c & d)) : b;

endmodule