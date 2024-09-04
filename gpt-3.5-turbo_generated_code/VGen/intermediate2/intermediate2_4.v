
module counter( 
    input clk,
    input reset,
    output reg [3:0] q
);
    
    // State initialization
    initial begin
        q = 4'b0001; // Start counting from 1
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0001; // Reset the counter to 1
        end else begin
            if (q < 4'b1100) begin // If q is less than 12 (1100 in binary)
                q <= q + 1; // Increment the counter
            end else begin
                q <= 4'b0001; // Wrap around to 1
            end
        end
    end

endmodule