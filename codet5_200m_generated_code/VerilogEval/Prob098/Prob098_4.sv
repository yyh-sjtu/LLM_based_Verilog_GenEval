module TopModule (
	input clk,
	input a,
	output q
);
    parameter WIDTH = 8;
    reg [WIDTH-1:0] code;
    initial code = 0;
    always @(posedge clk)
        code <= code + 1'b1;
    assign q = code;
endmodule

