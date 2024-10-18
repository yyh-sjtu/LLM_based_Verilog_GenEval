module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

reg out_both_output, out_any_output[3:1], out_different_output[3:0];

always @* begin
    out_both_output = (in[2] & in[3]) ? 1'b1 : 1'b0;
    out_any_output[2] = (in[2] | in[1]) ? 1'b1 : 1'b0;
    out_any_output[1] = (in[1] | in[0]) ? 1'b1 : 1'b0;
    out_any_output[3] = (in[3] | in[2]) ? 1'b1 : 1'b0;

    out_different_output[2] = (in[2] != in[3]) ? 1'b1 : 1'b0;
    out_different_output[1] = (in[1] != in[2]) ? 1'b1 : 1'b0;
    out_different_output[0] = (in[0] != in[3]) ? 1'b1 : 1'b0;
    out_different_output[3] = (in[3] != in[2]) ? 1'b1 : 1'b0;
end

assign out_both = {out_both_output, 2'b0};
assign out_any = {1'b0, out_any_output[3], out_any_output[2], out_any_output[1]};
assign out_different = out_different_output;

endmodule

