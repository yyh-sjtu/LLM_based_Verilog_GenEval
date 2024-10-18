
module JC_counter (
    input wire clk,
    input wire rst_n,
    output reg [63:0] Q
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Q <= 64'b0;  // Reset condition, set counter value to 0
    end
    else begin
        if (Q[0] == 0) begin
            Q <= {Q[63:1], 1'b1};  // Increment counter
        end
        else begin
            Q <= {Q[63:1], 1'b0};  // Decrement counter
        end
    end
end

endmodule