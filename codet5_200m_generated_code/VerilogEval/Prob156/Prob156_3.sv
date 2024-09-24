module TopModule (
	input clk,
	input reset,
	input data,
	output [3:0] count,
	output counting,
	output done,
	input ack
);
    reg [3:0] timer;
    reg [3:0] count_reg;
    reg done_reg;
    always @(posedge clk)
        if (reset)
            count_reg <= 0;
        else if (ack)
            count_reg <= count_reg + 1;
    always @(posedge clk)
        if (reset)
            done_reg <= 0;
        else if (count_reg == 1101)
            done_reg <= 1;
    always @(posedge clk)
        if (reset)
            count_reg <= 0;
        else if (count_reg == 1101)
            count_reg <= 0;
    always @(posedge clk)
        if (reset)
            count_reg <= 0;
        else if (count_reg == 1101)
            count_reg <= count_reg + 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (count_reg == 1101)
            count <= count_reg + 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (count_reg == 1101)
            count <= count_reg + 1;
    assign count = count_reg;
    assign done = done_reg;
endmodule

