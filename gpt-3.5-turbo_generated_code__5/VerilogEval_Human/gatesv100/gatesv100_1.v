module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// (1) out_both
// Each bit indicates whether both the corresponding input bit and its neighbor to the left are '1'
// We don't need to compute out_both[99] since it has no neighbor to the left.
generate
    gen_out_both: for (i = 0; i < 99; i = i + 1) begin
        assign out_both[i] = (in[i] & in[i+1]);
    end
endgenerate

// (2) out_any
// Each bit indicates whether any of the corresponding input bit and its neighbor to the right are '1'
// We don't need to compute out_any[0] since it has no neighbor to the right.
generate
    gen_out_any: for (i = 1; i < 100; i = i + 1) begin
        assign out_any[i] = (in[i] | in[i-1]);
    end
endgenerate

// (3) out_different
// Each bit indicates whether the corresponding input bit is different from its neighbor to the left
// We need to consider wrapping around, so in[99]'s neighbor to the left is in[0].
generate
    gen_out_different: for (i = 0; i < 100; i = i + 1) begin
        assign out_different[i] = (in[i] != in[(i+99)%100]);
    end
endgenerate

endmodule

