
module TopModule (
  input wire [1023:0] in,
  input wire [7:0] sel,
  output wire [3:0] out
);

  assign out = in[(8*sel)+3 : (8*sel)];

endmodule