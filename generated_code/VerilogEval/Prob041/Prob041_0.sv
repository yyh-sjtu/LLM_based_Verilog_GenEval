
module TopModule (
    input  wire clk,     // Clock input
    input  wire reset,   // Synchronous reset input
    input  wire [7:0] d, // 8-bit data input
    output reg [7:0] q   // 8-bit output
);

// Define a register for the output
always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // Set output to zero on reset
    end else begin
        q <= d; // Otherwise, set output to the input
    end
end

endmodule