
module edge_detect (
    input wire clk,
    input wire rst_n,
    input wire a,
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
        if (a && !a_prev) begin
            rise <= 1;
            down <= 0;
            a_prev <= a;
        end else if (!a && a_prev) begin
            rise <= 0;
            down <= 1;
            a_prev <= a;
        end else begin
            rise <= 0;
            down <= 0;
            a_prev = a;
        end
    end
end

endmodule