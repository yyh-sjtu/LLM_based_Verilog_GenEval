module TopModule (
	input a,
	input b,
	input c,
	input d,
	output q
);
    parameter [0:0] INIT = 1'b0;
    initial begin
        $display("## %L: Initializing the module");
    end
    always @(a or b or c or d) begin
        if (a)
            q <= INIT;
        else
            q <= d;
    end
endmodule

