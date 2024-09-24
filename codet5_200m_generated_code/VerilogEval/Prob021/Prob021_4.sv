module TopModule (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    genvar i;
    generate
        for (i = 0; i < 256; i = i + 1) begin: gen_sel 
            assign out[i] = in[sel]; 
        end
    endgenerate
endmodule

