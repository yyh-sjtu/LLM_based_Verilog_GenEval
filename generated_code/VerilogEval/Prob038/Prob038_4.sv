
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk)
begin
    if (reset) begin
        q <= 4'b0000;
    end
    else begin
        if (q == 4'b1111) begin
            q <= 4'b0000;
        end
        else begin
            q <= q + 1;
        end
    end
end

endmodule