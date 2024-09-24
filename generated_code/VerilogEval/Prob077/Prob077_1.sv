
module TopModule(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_output_1;
wire and_output_2;

assign and_output_1 = a & b;
assign and_output_2 = c & d;

assign out = and_output_1 | and_output_2;
assign out_n = ~out;

endmodule