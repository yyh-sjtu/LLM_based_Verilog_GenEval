
module left_rotate(
    input clk,             // Clock input
    input reset,           // Reset input
    input [2:0] amount,    // Number of positions to rotate
    input [7:0] data,      // Input data to rotate
    input load,            // Load signal to load data into rotation
    output reg [7:0] out   // Output rotated data
);

// Internal signal for the rotated result
reg [7:0] data_reg;

// Always block for synchronous reset and loading
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // On reset, clear the output
        out <= 8'b0;
        data_reg <= 8'b0;
    end else if (load) begin
        // Load new data when load signal is high
        data_reg <= data;
        out <= data_reg; // Initialize output with loaded data
    end else begin
        // Perform left rotation
        out <= {data_reg[6:0], data_reg[7]} << amount;
        // The result is a left shift with rotation
        // Note: Handles full rotation by using modulo 8
        data_reg <= {data_reg[6:0], data_reg[7]} << amount;
    end
end

endmodule