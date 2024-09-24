
module TopModule(
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    input  wire e,
    output wire [24:0] out
);

assign out[24] = ~(a ^ a);  // always 0
assign out[23] = ~(a ^ b);
assign out[22] = ~(a ^ c);
assign out[21] = ~(a ^ d);
assign out[20] = ~(a ^ e);
assign out[19] = ~(b ^ a);
assign out[18] = ~(b ^ b);  // always 0
assign out[17] = ~(b ^ c);
assign out[16] = ~(b ^ d);
assign out[15] = ~(b ^ e);
assign out[14] = ~(c ^ a);
assign out[13] = ~(c ^ b);
assign out[12] = ~(c ^ c);  // always 0
assign out[11] = ~(c ^ d);
assign out[10] = ~(c ^ e);
assign out[ 9] = ~(d ^ a);
assign out[ 8] = ~(d ^ b);
assign out[ 7] = ~(d ^ c);
assign out[ 6] = ~(d ^ d);  // always 0
assign out[ 5] = ~(d ^ e);
assign out[ 4] = ~(e ^ a);
assign out[ 3] = ~(e ^ b);
assign out[ 2] = ~(e ^ c);
assign out[ 1] = ~(e ^ d);
assign out[ 0] = ~(e ^ e);  // always 0

endmodule