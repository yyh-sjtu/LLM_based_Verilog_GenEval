module TopModule (
	input a,
	input b,
	input c,
	input d,
	output q
);
    parameter [0:0] INIT = 1'b0;
    initial begin
        $display("## %L: Initializing the module.");
    end
    always @(a, b, c, d) begin
        q <= INIT;
    end
endmodule

