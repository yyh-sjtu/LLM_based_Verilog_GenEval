
module edge_detect (
    input clk,
    input rst_n,
    input a,
    output reg rise,
    output reg down
);

reg a_dly;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        a_dly <= 1'b0;
        rise <= 1'b0;
        down <= 1'b0;
    end else begin
        a_dly <= a;
        
        if (a_dly == 1'b0 && a == 1'b1) begin
            rise <= 1'b1;
            down <= 1'b0;
        end else if (a_dly == 1'b1 && a == 1'b0) begin
            rise <= 1'b0;
            down <= 1'b1;
        end else begin
            rise <= 1'b0;
            down <= 1'b0;
        end
    end
end

endmodule