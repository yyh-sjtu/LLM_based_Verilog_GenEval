module TopModule (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] d;
    always @(posedge clk or negedge resetn)
        if (!resetn)
            d <= 0;
        else
            d <= d << 1;
    assign out = d[3];
endmodule

