module TopModule (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output Z
);
    reg [7:0] mem [0:7];
    always @(posedge clk)
        if (enable)
            mem[0] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[1] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[2] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[3] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[4] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[5] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[6] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[7] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[8] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[9] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[10] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[11] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[12] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[13] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[14] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[15] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[16] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[17] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[18] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[19] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[20] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[21] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[22] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[23] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[24] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[25] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[26] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[27] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[28] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[29] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[30] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[31] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[32] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[33] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[34] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[35] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[36] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[37] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[38] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[39] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[39] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[40] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[41] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[42] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[43] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[44] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[45] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[45] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[45] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[46] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[47] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[46] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[47] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[47] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[47] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[48] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[47] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[48] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : C;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : B;
    always @(posedge clk)
        if (enable)
            mem[49] <= S? A : C;
    endmodule

