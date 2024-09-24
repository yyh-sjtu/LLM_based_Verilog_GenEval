module TopModule (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output Z
);
    reg [7:0] shift_reg;
    always @(posedge clk)
        if (enable)
            shift_reg <= {shift_reg[7:0], S};
    assign Z = shift_reg[0];
    always @(posedge clk)
        if (enable)
            shift_reg <= {shift_reg[7:0], A};
    always @(posedge clk)
        if (enable)
            shift_reg <= {shift_reg[7:0], B};
    always @(posedge clk)
        if (enable)
            shift_reg <= {shift_reg[7:0], C};
endmodule

