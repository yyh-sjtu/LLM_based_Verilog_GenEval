
module TopModule(
  input a,
  input b,
  input c,
  input d,
  output reg out
);
  always @(*) begin
    case({c, d, a, b})
      4'b0000, 4'b0100: out = 0;
      4'b0001: out = 0;
      4'b0010: out = d; // don't care
      4'b0011: out = d; // don't care
      default: out = 1;
    endcase
  end
endmodule