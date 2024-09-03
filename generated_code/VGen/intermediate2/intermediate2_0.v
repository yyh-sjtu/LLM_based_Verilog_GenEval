module counter(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // initialize the counter to 1
    end else begin
        if (q == 4'b1100) begin
            q <= 4'b0000; // reset counter to 0 when it reaches 12
        end else begin
            q <= q + 4'b0001; // increment counter by 1
        end
    end
end

endmodule

