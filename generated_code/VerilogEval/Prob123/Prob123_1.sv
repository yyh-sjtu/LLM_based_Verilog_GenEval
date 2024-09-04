
synthesis verilog_input_version verilog_2001
module TopModule (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

  always @(*) begin
      // Perform the addition or subtraction based on the value of do_sub
      if (do_sub) begin
          out = a - b;
      end else begin
          out = a + b;
      end

      // Determine if the result is zero
      if (out == 8'b0) begin
          result_is_zero = 1'b1;
      end else begin
          result_is_zero = 1'b0;
      end
  end

endmodule