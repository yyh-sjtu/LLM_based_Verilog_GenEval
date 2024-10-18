
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
        a_prev <= 1'b0;
    end else begin
        if (a & ~a_prev) begin
            rise <= 1;
        end else begin
            rise <= 0;
        end
        
        if (~a & a_prev) begin
            down <= 1;
        end else begin
            down <= 0;
        end
        
        a_prev <= a;
    end
end

endmodule