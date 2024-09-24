
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire out
);

assign out = (b & ~c) | (b & c) | (~b & c); // out = b'c + bc + ac

endmodule