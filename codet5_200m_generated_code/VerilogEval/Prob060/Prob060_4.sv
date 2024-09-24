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
            dff <= {dff[0], in};
    assign out = dff[3];
endmodule

