module JC_counter (
    input wire clk,
    input wire rst_n,
    output wire [63:0] Q
);

reg [63:0] Q;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Q <= 64'b0; // Reset condition, counter value set to 0
    end else if (Q[0] == 1'b0) begin
        Q <= {Q[62:0], 1'b1}; // Increment by shifting current value to the right and appending 1
    end else begin
        Q <= {Q[62:0], 1'b0}; // Decrement by shifting current value to the right and appending 0
    end
end

endmodule

