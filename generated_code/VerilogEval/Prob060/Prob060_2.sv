
module TopModule (
    input  wire clk,      // Clock input
    input  wire resetn,   // Active-low reset
    input  wire in,       // Input data
    output wire out       // Output data
);

    // Internal register to hold the state of the shift register
    reg [3:0] shift_reg;  // 4-bit shift register

    // Shift register functionality
    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000;  // Reset shift register to 0
        end else begin
            // Shift the register left and insert the new input
            shift_reg <= {shift_reg[2:0], in}; 
        end
    end

    // Output the most significant bit of the shift register
    assign out = shift_reg[3];

endmodule