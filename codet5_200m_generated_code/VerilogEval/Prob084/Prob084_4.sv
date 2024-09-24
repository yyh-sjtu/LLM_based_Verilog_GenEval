module TopModule (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output Z
);
    reg [7:0] shiftreg;
    always @(posedge clk)
        if (enable)
            shiftreg <= {shiftreg[7:0], S};
    assign Z = shiftreg[0];
    always @(posedge clk)
        if (enable)
            shiftreg <= {shiftreg[7:0], A};
    always @(posedge clk)
        if (enable)
            shiftreg <= {shiftreg[7:0], B};
    always @(posedge clk)
        if (enable)
            shiftreg <= {shiftreg[7:0], C};
endmodule

