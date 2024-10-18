
module TopModule (
  input [2:0] in,
  output reg [1:0] out
);

  always @(*) begin
    out = in[0] + in[1] + in[2];
  end

endmodule