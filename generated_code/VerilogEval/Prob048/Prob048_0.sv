
module TopModule (
    input  wire clk,  // Clock input
    input  wire d,    // Data input
    input  wire r,    // Reset input (active high)
    output reg  q     // Output
);

// Always block triggered on the rising edge of clk
// or when reset is asserted
always @(posedge clk or posedge r) begin
    if (r) begin
        // If reset is high, set q to 0
        q <= 1'b0;
    end else begin
        // Otherwise, set q to d
        q <= d;
    end
end

endmodule