
module TopModule (
    input  wire clk,   // Clock input
    input  wire d,     // Data input
    input  wire r,     // Reset input
    output reg  q      // Data output
);

    // Always block triggered on the rising edge of clk
    always @(posedge clk) begin
        if (r) begin
            // If reset is high, set output to 0
            q <= 1'b0;
        end else begin
            // Otherwise, transfer the input d to output q
            q <= d;
        end
    end

endmodule