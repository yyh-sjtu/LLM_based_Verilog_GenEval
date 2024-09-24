
module TopModule (
    input  [31:0] in,  // 32-bit input
    output [31:0] out  // 32-bit output
);

    // Reversing the byte order
    assign out = {in[7:0], in[15:8], in[23:16], in[31:24]};

endmodule