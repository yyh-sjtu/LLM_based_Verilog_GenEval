
synthesis verilog_input_version verilog_2001
module TopModule (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Perform addition or subtraction based on do_sub signal
        if (do_sub) begin
            out = a - b;  // Subtract b from a
        end else begin
            out = a + b;  // Add a and b
        end

        // Check if the output is zero
        if (out == 8'b0) begin
            result_is_zero = 1;  // Set the zero flag
        end else begin
            result_is_zero = 0;  // Clear the zero flag
        end
    end

endmodule