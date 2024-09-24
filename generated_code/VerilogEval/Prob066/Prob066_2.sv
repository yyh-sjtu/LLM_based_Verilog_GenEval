
module TopModule (
    input wire clk,
    input wire reset,
    input wire [31:0] in,
    output reg out
);

    // Internal signal to track the previous state of input
    reg [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset
            out <= 1'b0;          // Reset the output
            prev_in <= 32'b0;     // Reset the previous input
        end else begin
            // Check for rising edge from 1 to 0 in any of the bits
            if (prev_in == 1'b1 && in == 1'b0) begin
                out <= 1'b1;      // Set output to 1 if condition is met
            end else begin
                out <= out;       // Maintain current output state
            end
            
            // Update previous input for the next cycle
            prev_in <= in;
        end
    end

endmodule