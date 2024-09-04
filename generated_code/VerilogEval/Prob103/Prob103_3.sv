
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);
    assign q = ( (a == 0 && ( (b == 0 && d) || (b == 0 && c) || (b && c) ) ) ) ||
                 ( (a == 1 && ( (b == 0 && d) || (b == 0 && c) || (b && ~d) ) ) ) );

endmodule