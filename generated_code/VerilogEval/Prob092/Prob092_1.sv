
module TopModule(
    input [99:0] in,
    output [99:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    genvar i;

    // Calculate out_both
    assign out_both[0] = (in[0] & in[1]);
    generate
        for (i = 1; i < 99; i = i + 1) begin
            assign out_both[i] = (in[i] & in[i+1]);
        end
        assign out_both[99] = 0;
    endgenerate

    // Calculate out_any
    assign out_any[99] = (in[99] | in[0]);
    generate
        for (i = 0; i < 99; i = i + 1) begin
            assign out_any[i] = (in[i] | in[i+1]);
        end
    endgenerate

    // Calculate out_different
    assign out_different[0] = (in[0] ^ in[99]);
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_different[i] = (in[i] ^ in[i-1]);
        end
    endgenerate

endmodule