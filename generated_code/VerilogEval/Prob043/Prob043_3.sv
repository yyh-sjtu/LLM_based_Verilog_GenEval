
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    input wire e,
    output reg [24:0] out
);

    always @(*) begin
        out[24] = ~(a ^ a); // comparison of a with a
        out[23] = ~(a ^ b); // comparison of a with b
        out[22] = ~(a ^ c); // comparison of a with c
        out[21] = ~(a ^ d); // comparison of a with d
        out[20] = ~(a ^ e); // comparison of a with e
        out[19] = ~(b ^ b); // comparison of b with b
        out[18] = ~(b ^ a); // comparison of b with a
        out[17] = ~(b ^ c); // comparison of b with c
        out[16] = ~(b ^ d); // comparison of b with d
        out[15] = ~(b ^ e); // comparison of b with e
        out[14] = ~(c ^ c); // comparison of c with c
        out[13] = ~(c ^ a); // comparison of c with a
        out[12] = ~(c ^ b); // comparison of c with b
        out[11] = ~(c ^ d); // comparison of c with d
        out[10] = ~(c ^ e); // comparison of c with e
        out[ 9] = ~(d ^ d); // comparison of d with d
        out[ 8] = ~(d ^ a); // comparison of d with a
        out[ 7] = ~(d ^ b); // comparison of d with b
        out[ 6] = ~(d ^ c); // comparison of d with c
        out[ 5] = ~(d ^ e); // comparison of d with e
        out[ 4] = ~(e ^ e); // comparison of e with e
        out[ 3] = ~(e ^ a); // comparison of e with a
        out[ 2] = ~(e ^ b); // comparison of e with b
        out[ 1] = ~(e ^ c); // comparison of e with c
        out[ 0] = ~(e ^ d); // comparison of e with d
    end
endmodule