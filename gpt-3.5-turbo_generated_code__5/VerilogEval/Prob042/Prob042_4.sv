
module TopModule (
    input [7:0] in,
    output reg [31:0] out
);

  reg [23:0] replicated_sign;

  always @(*) begin
    replicated_sign = {24{in[7]}};
    out = {replicated_sign, in};
  end

endmodule