
synthesis verilog_input_version verilog_2001
module TopModule (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Perform the addition or subtraction based on the control signal
        case (do_sub)
            1'b0: out = a + b;  // Addition
            1'b1: out = a - b;  // Subtraction
            default: out = 8'b0; // Safeguard against any unintended cases
        endcase

        // Evaluate the zero flag
        if (out == 8'b0)
            result_is_zero = 1'b1; // Set zero flag if out is zero
        else
            result_is_zero = 1'b0;  // Clear zero flag otherwise
    end

endmodule