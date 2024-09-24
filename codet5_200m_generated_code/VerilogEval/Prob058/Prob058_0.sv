module TopModule (
	input clk,
	input a,
	input b,
	output out_assign,
	output out_always_comb,
	output out_always_ff
);
    assign out_assign = a ^ b;
    always @(posedge clk) begin
        out_always_comb = a ^ b;
        out_always_ff = a ^ b;
    end
endmodule

