
module count_slow (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

    always @ (posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            if (q == 4'b1001 && slowena) begin
                q <= 4'b0000;
            end else if (slowena) begin
                q <= q + 1;
            end
        end
    end

endmodule