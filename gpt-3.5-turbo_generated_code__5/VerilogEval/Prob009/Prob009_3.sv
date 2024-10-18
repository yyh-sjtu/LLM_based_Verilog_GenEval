
module TopModule (
  input [2:0] in,
  output reg [1:0] out
);

always @(*) begin
  out = 0;
  for (int i=0; i<3; i=i+1) begin
    out = out + in[i];
  end
end

endmodule