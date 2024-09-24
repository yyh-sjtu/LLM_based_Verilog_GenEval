
module TopModule (
    input wire a,
    input wire b,
    output wire out
);

// Implement the XNOR operation
assign out = ~(a ^ b);

endmodule