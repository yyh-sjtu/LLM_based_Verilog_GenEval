
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);

    assign q = (a & b & c) | (a & b & d) | (a & c & d) | 
               (b & c & d) | (!a & b & c) | (!a & b & d) | 
               (!a & c & d) | (!b & c & d) | 
               (!a & !b & d) | (!a & !b & c);

endmodule