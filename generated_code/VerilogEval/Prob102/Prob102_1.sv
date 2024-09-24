
module TopModule(
    input a,
    input b,
    input c,
    input d,
    output q
);

assign q = (a & b) | (~b & c) | (c & d);

endmodule