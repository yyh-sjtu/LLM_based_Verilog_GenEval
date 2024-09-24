module count_slow (
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
);
    parameter [3:0] MAX = 4'b0000;
    reg [3:0] count;
    always @(posedge clk)
        if (reset)
            count <= MAX;
        else if (slowena)
            count <= count + 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
        else if (slowena)
            count <= count - 1;
    always @(posedge clk)
        if (reset)
            count <= 0;
    always @(posedge clk)
        if (reset)
            q <= 0;
        else if (slowena)
            q <= count - 1;
endmodule

