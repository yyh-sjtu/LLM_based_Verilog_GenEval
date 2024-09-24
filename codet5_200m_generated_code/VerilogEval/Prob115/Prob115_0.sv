module TopModule (
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output [63:0] q
);
    reg [63:0] shifter;
    always @(posedge clk)
        if (load)
            shifter <= data;
        else if (ena)
            shifter <= shifter + amount;
    assign q = shifter;
endmodule

