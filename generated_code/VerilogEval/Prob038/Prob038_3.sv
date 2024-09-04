
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0
    end else begin
        if (q == 4'b1111) begin
            q <= 4'b0000; // Reset the counter to 0 when it reaches 15
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule