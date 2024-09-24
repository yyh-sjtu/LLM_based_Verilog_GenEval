module TopModule (
	input clk,
	input reset,
	output [4:0] q
);
    reg [4:0] lfsr;
    reg [4:0] tap;
    always @(posedge clk or posedge reset)
        if (reset)
            lfsr <= 1'b1;
        else
            lfsr <= {lfsr[4], lfsr[3] ^ lfsr[2] ^ lfsr[1] ^ lfsr[0]};
    assign q = lfsr[5];
endmodule

