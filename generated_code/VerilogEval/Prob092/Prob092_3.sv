
module TopModule (
    input  [99:0] in,
    output [99:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both: Both the current bit and its left neighbor are '1'
    assign out_both[99] = 1'b0;  // in[99] has no left neighbor
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_gen
            assign out_both[i] = in[i] & in[i + 1];  // in[i] and in[i + 1]
        end
    endgenerate

    // Generate out_any: Any of the current bit and its right neighbor is '1'
    assign out_any[0] = 1'b0;  // in[0] has no right neighbor
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_gen
            assign out_any[i] = in[i] | in[i - 1];  // in[i] and in[i - 1]
        end
    endgenerate

    // Generate out_different: Current bit differs from its left neighbor, treat as wrapping
    genvar j;
    generate
        for (j = 0; j < 100; j = j + 1) begin : out_different_gen
            assign out_different[j] = in[j] ^ in[(j + 1) % 100];  // in[j] and in[(j + 1) % 100]
        end
    endgenerate

endmodule