
module TopModule(
    input wire a,
    input wire b,
    output wire q
);

    // Implementing a combinational circuit that outputs q = a AND b
    assign q = a & b;

endmodule