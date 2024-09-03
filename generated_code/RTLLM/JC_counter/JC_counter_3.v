
module JC_counter(
    input wire clk,
    input wire rst_n, 
    output reg [63:0] Q
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        Q <= 64'b0; // Reset the counter
    end else begin
        if (Q[0] == 1'b0) begin
            Q <= {Q[63:1], 1'b1}; // Increment the counter
        end else begin
            Q <= {Q[63:1], 1'b0}; // Decrement the counter
        end
    end
end

endmodule