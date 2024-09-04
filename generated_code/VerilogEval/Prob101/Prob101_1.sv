
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire q
);

// Combinational logic
assign q = (~a & (b | c)) | (a & (b | c));

endmodule