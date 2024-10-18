
module TopModule(
    input  a,
    input  b,
    input  c,
    input  d,
    output q
);

    assign q = (~a & ~b & ~c) | (~a & b & ~c) | (~a & b & c) | (a & ~b & d) | (a & b & d);

endmodule