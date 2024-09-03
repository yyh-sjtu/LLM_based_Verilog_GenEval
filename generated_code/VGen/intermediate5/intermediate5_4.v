module
module full_adder_16bit (
    input [15:0] A, // First 16-bit input
    input [15:0] B, // Second 16-bit input
    input carry_in, // Input carry
    output [15:0] sum, // 16-bit output sum
    output carry_out // Output carry
);

// Define internal signals
wire [15:0] sum_intermediate; // Intermediate sum
wire carry_intermediate1, carry_intermediate2; // Intermediate carry signals

// Implement 16-bit full adder using logic gates
assign {carry_intermediate1, sum_intermediate} = A + B + carry_in; // Add inputs A, B, and carry_in

assign sum = sum_intermediate; // Assign intermediate sum to output sum

// Generate carry_out based on intermediate carries
assign carry_out = carry_intermediate1 | carry_intermediate2;

endmodule

module
module left_rotate_shift_16bit (
    input clk, // Clock input
    input reset, // Reset signal input
    input [2:0] amount, // Amount of shift
    input [15:0] data, // 16-bit input data
    input load, // Load signal
    output reg [15:0] out // 16-bit output
);

reg [15:0] data_shifted; // Define register for shifted data

// Implement left shift and rotate operation
always @(posedge clk) begin
    if (reset) begin
        data_shifted <= 16'h0000; // Reset to 0
    end else begin
        if (load) begin
            data_shifted <= data << amount; // Shift left by amount
        end else begin
            data_shifted <= {data_shifted[14:0], data_shifted[15]}; // Rotate left by 1
        end
    end
end

// Output the shifted data
always @* begin
    out = data_shifted; // Assign shifted data to output
end

endmodule
