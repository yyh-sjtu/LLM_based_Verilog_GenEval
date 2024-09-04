
module TopModule(
    input clk,
    input reset,
    output reg [3:0] q
);

// Decade counter logic
always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001;
    end else begin
        if (q == 4'b1010) begin
            q <= 4'b0001;
        end else begin
            q <= q + 1;
        end
    end
end

endmodule