
module TopModule (
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

// Asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset the shift register
        q <= 4'b0000;
    end else begin
        // Check load and ena conditions
        if (load) begin
            // Load new data into the shift register
            q <= data;
        end else if (ena) begin
            // Shift right
            q <= {1'b0, q[3:1]}; // Shift right and zero-fill the leftmost bit
        end
        // If neither load nor ena are asserted, q remains unchanged
    end
end

endmodule