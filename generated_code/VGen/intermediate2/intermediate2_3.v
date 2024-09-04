module counter(
    input clk,
    input reset,
    output reg [3:0] q
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0001; // Initialize counter to 1
        end else begin
            if (q == 4'b1100) begin
                q <= 4'b0001; // Reset counter to 1 when it reaches 12
            end else begin
                q <= q + 1; // Increment counter
            end
        end
    end

endmodule

