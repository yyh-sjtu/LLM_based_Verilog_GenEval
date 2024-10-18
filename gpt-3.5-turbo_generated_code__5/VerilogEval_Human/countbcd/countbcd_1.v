module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [15:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end
        else begin
            q <= next_q;
        end
    end

    assign ena = q[11:9];

    always @(*) begin
        next_q = q + 1;
    end

endmodule

