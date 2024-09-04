
module TopModule (
    input [7:0] in,
    output parity
);

assign parity = ^in; // XOR operation on the 8 data bits

endmodule