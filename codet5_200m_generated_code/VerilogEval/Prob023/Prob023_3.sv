module TopModule (
	input [99:0] in,
	output [99:0] out
);
    genvar i;
    assign out = in[99:1];
    genvar j;
    generate
        for (j = 0; j < 99; j = j + 1) begin: reverse_codes
            assign out[j] = in[j-1];
        end
    endgenerate
endmodule

