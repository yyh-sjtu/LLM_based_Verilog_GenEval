
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);

  always @(*) begin
    case(in)
      4'b0001: pos = 2'b0; // input[0] is high
      4'b0010: pos = 2'b1; // input[1] is high
      4'b0100: pos = 2'b2; // input[2] is high
      4'b1000: pos = 2'b3; // input[3] is high
      default: pos = 2'b0; // none of the input bits are high
    endcase
  end

endmodule