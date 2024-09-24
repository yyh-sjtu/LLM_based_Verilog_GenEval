module TopModule (
	input clk,
	input reset,
	output [31:0] q
);
    reg [31:0] lfsr [0:32];
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
            lfsr[0] <= 32'h1;
        else
            lfsr[0] <= {lfsr[31:16], lfsr[22:1]};
    end
    assign q = lfsr[0];
endmodule

