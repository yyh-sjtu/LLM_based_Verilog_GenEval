
module TopModule(
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

  reg [7:0] tmp_min1;
  reg [7:0] tmp_min2;

  always @(*)
  begin
    tmp_min1 = (a < b) ? a : b;
    tmp_min2 = (c < d) ? c : d;
    min = (tmp_min1 < tmp_min2) ? tmp_min1 : tmp_min2;
  end

endmodule