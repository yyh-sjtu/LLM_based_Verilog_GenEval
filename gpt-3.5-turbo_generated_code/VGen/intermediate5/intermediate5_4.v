
module left_rotate(
    input clk,
    input reset,
    input [2:0] amount,  // Amount to shift/rotate
    input [7:0] data,    // Data to shift/rotate
    input load,          // Load signal to load new data
    output reg [7:0] out // Output after rotation
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 8'b0; // Clear the output on reset
        end else if (load) begin
            out <= data; // Load new data if load signal is high
        end else begin
            // Perform left rotation
            out <= (out << amount) | (out >> (8 - amount));
        end
    end

endmodule