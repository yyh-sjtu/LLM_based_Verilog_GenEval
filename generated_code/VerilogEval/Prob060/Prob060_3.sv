
module TopModule (
    input  clk,
    input  resetn,
    input  in,
    output reg out
);

    // Declare the shift register as a 4-bit wide register
    reg [3:0] shift_reg;

    // Sequential logic for the shift register
    always @(posedge clk) begin
        if (!resetn) begin
            // Reset the shift register to 0 on active-low reset
            shift_reg <= 4'b0000;
            out <= 0; // Also reset the output
        end else begin
            // Shift the input through the register
            shift_reg <= {shift_reg[2:0], in};
            out <= shift_reg[3]; // Assign the MSB of the shift register to the output
        end
    end

endmodule