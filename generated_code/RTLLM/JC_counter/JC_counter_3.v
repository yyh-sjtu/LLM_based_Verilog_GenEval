module JC_counter (
    input wire clk,    // Clock signal
    input wire rst_n,  // Active-low reset signal
    output reg [63:0] Q // 64-bit count value
);

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n) begin
        Q <= 64'b0; // Reset condition
    end else begin
        // Update counter value based on LSB
        if (Q[0] == 1'b0) begin
            Q <= {Q[63:1], 1'b1}; // Increment counter
        end else begin
            Q <= {Q[63:1], 1'b0}; // Decrement counter
        end
    end
end

endmodule

