
module TopModule (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output [3:0] q
);

assign q = (
    (c == 4'b0000) ? b :
    (c == 4'b0001) ? e :
    (c == 4'b0010) ? a :
    (c == 4'b0011) ? d :
    4'b1111
);

endmodule