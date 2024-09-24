module multi_pipe_4bit (
    input clk,
    input rst_n,
    input [3:0] mul_a,
    input [3:0] mul_b,
    output [7:0] mul_out
);
    reg [7:0] a, b;
    reg [7:0] c;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a <= 0;
            b <= 0;
            c <= 0;
        end else begin
            if (c == 0) begin
                a <= mul_a;
                b <= mul_b;
            end else begin
                a <= a + mul_b;
                b <= b + mul_a;
            end
        end
    end
    assign mul_out = c;
endmodule

