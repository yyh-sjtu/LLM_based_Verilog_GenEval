module advshift (
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q
);
    reg [63:0] shiftreg;
    always @(posedge clk)
        if (load)
            shiftreg <= data;
        else if (ena)
            shiftreg <= {shiftreg[63:0], data};
    always @(posedge clk)
        if (load)
            q <= shiftreg;
        else if (ena)
            q <= {shiftreg[63:0], data};
endmodule

