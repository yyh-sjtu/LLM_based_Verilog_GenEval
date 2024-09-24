module TopModule (
	input a,
	input b,
	input c,
	input d,
	output q
);
    parameter [31:0] INIT = 32'h00000000;
    initial begin
        $display("## %L: Initializing the module with input signals %h and output signal %h", $time, INIT, d);
    end
    always @(a, b, c, d) begin
        $display("## %L: Initializing the module with input signals %h and output signal %h", $time, INIT, d);
    end
    assign q = INIT;
endmodule

