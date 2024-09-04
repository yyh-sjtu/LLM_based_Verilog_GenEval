
module TopModule (
    input [99:0] in,
    output [99:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

assign out_both[0] = (in[0] & in[1]);
assign out_any[0] = (in[0] | in[99]);
assign out_different[0] = (in[0] != in[99]);

genvar i;
generate
    for (i = 1; i < 100; i++) begin
        assign out_both[i] = (in[i] & in[i-1]);
        assign out_any[i] = (in[i] | in[i-1]);
        assign out_different[i] = (in[i] != in[i-1]);
    end
endgenerate

endmodule