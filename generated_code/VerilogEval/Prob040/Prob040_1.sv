
module TopModule (
    input wire clk,      // Clock input
    input wire reset,    // Synchronous reset
    output reg [3:0] q   // 4-bit output for the counter
);
    
    // Always block triggered on the positive clock edge
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Reset to 0 after counting to 9
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end
    
endmodule