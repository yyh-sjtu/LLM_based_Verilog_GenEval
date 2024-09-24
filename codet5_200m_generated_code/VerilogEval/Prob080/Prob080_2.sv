module TopModule (
	input clk,
	input load,
	input [9:0] data,
	output tc
);
    reg [9:0] count;
    always @(posedge clk)
        if (load)
            count <= count + 1;
    assign tc = count == 0;
endmodule

