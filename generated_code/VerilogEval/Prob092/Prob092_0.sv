
module TopModule (
    input  [99:0] in,
    output [99:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate out_both
    assign out_both[99] = 1'b0;  // without left neighbor
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : both_gen
            assign out_both[i] = in[i] & in[i + 1];
        end
    endgenerate

    // Generate out_any
    assign out_any[0] = 1'b0;  // without right neighbor
    generate
        for (i = 1; i < 100; i = i + 1) begin : any_gen
            assign out_any[i] = in[i] | in[i - 1];
        end
    endgenerate

    // Generate out_different
    assign out_different[0] = (in[0] !== in[99]);  // wrapping around case
    generate
        for (i = 1; i < 100; i = i + 1) begin : different_gen
            assign out_different[i] = (in[i] !== in[i - 1]);
        end
    endgenerate

endmodule