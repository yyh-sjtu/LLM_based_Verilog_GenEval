
module TopModule (
    input clk,
    input reset,
    output reg [4:0] q
);

    // XOR positions based on taps (5 and 3)
    wire feedback;
    
    // Calculate feedback as XOR of tapped bits
    assign feedback = q[4] ^ q[2]; // Taps at position 5 (q[4]) and position 3 (q[2])

    // On the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset to 1
            q <= 5'b00001; // Reset to a non-zero state (1)
        end else begin
            // Shift left and insert feedback
            q <= {q[3:0], feedback}; // Shift register with feedback
        end
    end

endmodule