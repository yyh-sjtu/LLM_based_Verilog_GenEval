
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

reg a_last;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rise <= 0;
        down <= 0;
        a_last <= 0;
    end else begin
        rise <= (a & ~a_last);
        down <= (~a & a_last);
        a_last <= a;
    end
end

endmodule