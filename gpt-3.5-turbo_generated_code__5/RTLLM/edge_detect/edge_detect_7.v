
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

reg a_delay;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
        a_delay <= 0;
    end else begin
        a_delay <= a;
        if (a_delay && !a) begin
            rise <= 1;
            down <= 0;
        end else if (!a_delay && a) begin
            rise <= 0;
            down <= 1;
        end else begin
            rise <= 0;
            down <= 0;
        end
    end
end

endmodule