
module left_rotate(
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 8'b0;  // Reset output to zero
        end else if (load) begin
            out <= data;  // Load data when load signal is high
        end else begin
            // Perform left rotate operation
            out <= (out << amount) | (out >> (8 - amount));
        end
    end
endmodule