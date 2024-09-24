module TopModule (
	input clk,
	input resetn,
	input in,
	output out
);
    reg [3:0] dff;
    always @(posedge clk or negedge resetn)
        if (!resetn)
            dff <= 0;
        else
            dff <= {dff[3], in};
    assign out = dff[0];
endmodule

