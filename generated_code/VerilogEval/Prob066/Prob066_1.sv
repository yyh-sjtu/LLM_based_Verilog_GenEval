
module TopModule (
    input  wire        clk,     // Clock input
    input  wire        reset,   // Synchronous reset input
    input  wire [31:0] in,      // 32-bit input
    output reg  [31:0] out      // 32-bit output
);

    reg [31:0] prev_in; // Register to hold the previous state of the input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset the output to 0
            prev_in <= 32'b0; // Reset previous input state
        end else begin
            // Capture rising edge transitions from 1 to 0 in the input
            for (int i = 0; i < 32; i = i + 1) begin
                if (prev_in[i] == 1'b1 && in[i] == 1'b0) begin
                    out[i] <= 1'b1; // Transition detected: set output
                end
            end
            // Update previous input state
            prev_in <= in;
        end
    end

endmodule