
module lfsr(
    input clk,
    input reset,
    output [4:0] q
);
    reg [4:0] r_reg;                // Register to hold current state
    wire feedback_value;            // Feedback value for LFSR
    wire [4:0] r_next;             // Next state of the LFSR

    // Feedback is based on the taps at bit positions 5 and 3
    assign feedback_value = r_reg[4] ^ r_reg[2]; // Taps at 5 (r_reg[4]) and 3 (r_reg[2])
    
    // Calculate the next state
    assign r_next = {r_reg[3:0], feedback_value}; // Shift left and insert feedback

    // Update the register on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_reg <= 5'b00001; // Initial state (non-zero to avoid zero state)
        end
        else begin
            r_reg <= r_next; // Update the register to the next state
        end
    end

    // Assign the output to the current state of the register
    assign q = r_reg;

endmodule