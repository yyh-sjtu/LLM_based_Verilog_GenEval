
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    input  wire e,
    output wire [24:0] out
);
    
    assign out[24] = ~(a ^ a); // comparison of a with itself
    assign out[23] = ~(a ^ b); // comparison of a with b
    assign out[22] = ~(a ^ c); // comparison of a with c
    assign out[21] = ~(a ^ d); // comparison of a with d
    assign out[20] = ~(a ^ e); // comparison of a with e
    assign out[19] = ~(b ^ a); // comparison of b with a
    assign out[18] = ~(b ^ b); // comparison of b with itself
    assign out[17] = ~(b ^ c); // comparison of b with c
    assign out[16] = ~(b ^ d); // comparison of b with d
    assign out[15] = ~(b ^ e); // comparison of b with e
    assign out[14] = ~(c ^ a); // comparison of c with a
    assign out[13] = ~(c ^ b); // comparison of c with b
    assign out[12] = ~(c ^ c); // comparison of c with itself
    assign out[11] = ~(c ^ d); // comparison of c with d
    assign out[10] = ~(c ^ e); // comparison of c with e
    assign out[9]  = ~(d ^ a); // comparison of d with a
    assign out[8]  = ~(d ^ b); // comparison of d with b
    assign out[7]  = ~(d ^ c); // comparison of d with c
    assign out[6]  = ~(d ^ d); // comparison of d with itself
    assign out[5]  = ~(d ^ e); // comparison of d with e
    assign out[4]  = ~(e ^ a); // comparison of e with a
    assign out[3]  = ~(e ^ b); // comparison of e with b
    assign out[2]  = ~(e ^ c); // comparison of e with c
    assign out[1]  = ~(e ^ d); // comparison of e with d
    assign out[0]  = ~(e ^ e); // comparison of e with itself
    
endmodule