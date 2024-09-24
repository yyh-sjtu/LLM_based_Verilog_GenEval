module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output [7:0] mul_out
);
    reg [7:0] a, b;
    reg [7:0] c;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            a <= 0;
        else
            a <= a + mul_a;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            b <= 0;
        else
            b <= b + mul_b;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            c <= 0;
        else
            c <= c + mul_a;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            c <= 0;
        else
            c <= c + mul_a;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            c <= 0;
        else
            c <= c + mul_b;
    assign mul_out = c;
endmodule

