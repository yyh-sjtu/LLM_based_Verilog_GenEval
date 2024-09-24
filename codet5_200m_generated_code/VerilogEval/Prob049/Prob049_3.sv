module TopModule (
	input clk,
	input ar,
	input d,
	output q
);
    parameter [31:0] INIT = 32'h00000000;
    reg [31:0] q;
    always @(posedge clk or posedge ar)
        if (ar) q <= INIT;
    assign q = q;
endmodule

