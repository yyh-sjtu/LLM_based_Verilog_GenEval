
module TopModule (
    input wire clk,        // Clock input
    input wire resetn,    // Active-low synchronous reset
    input wire in,        // Serial input
    output reg out        // Serial output
);

    // Internal 4-bit shift register
    reg [3:0] shift_reg;

    // Sequential logic for the shift register
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Synchronous reset: clear the shift register
            shift_reg <= 4'b0000;
        end else begin
            // Shift left by one position and insert the new input bit
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    // The output is the MSB of the shift register
    assign out = shift_reg[3];

endmodule