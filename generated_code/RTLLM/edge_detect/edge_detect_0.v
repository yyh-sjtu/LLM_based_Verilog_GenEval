
module edge_detect(
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

reg a_prev;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
        a_prev <= 0;
    end else begin
        if (a == 1 && a_prev == 0) begin
            rise <= 1;
            down <= 0;
            a_prev <= 1;
        end else if (a == 0 && a_prev == 1) begin
            rise <= 0;
            down <= 1;
            a_prev <= 0;
        end else begin
            rise <= 0;
            down <= 0;
        end
    end
end

endmodule