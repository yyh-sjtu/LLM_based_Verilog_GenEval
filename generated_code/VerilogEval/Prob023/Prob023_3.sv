
module TopModule (
    input  [99:0] in,   // 100-bit input
    output [99:0] out   // 100-bit output
);

    // Intermediate wire for output
    wire [99:0] reversed_bits;

    // Generate statements to reverse the bits
    generate
        genvar i;
        for (i = 0; i < 100; i = i + 1) begin : reverse_bits
            assign reversed_bits[i] = in[99 - i];
        end
    endgenerate

    // Assign the reversed bits to output
    assign out = reversed_bits;

endmodule