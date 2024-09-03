
module adder_8bit(
  input a,
  input b,
  input Cin,
  output y,
  output Co
);

assign {Co, y} = {Cin, a} + b;

endmodule

module adder_16bit(
  input [15:0] a,
  input [15:0] b,
  input Cin,
  output reg [15:0] y,
  output reg Co
);

reg [7:0] carry;
reg [7:0] sum;

adder_8bit adder[7:0](
  .a(a[7*2 +: 8]),
  .b(b[7*2 +: 8]),
  .Cin(carry[6]),
  .y(sum[7*2 +: 8]),
  .Co(carry[7])
);

always @(*) begin
  carry[0] = Cin;
  carry[1] = sum[0][8];
  carry[2] = sum[1][8];
  carry[3] = sum[2][8];
  carry[4] = sum[3][8];
  carry[5] = sum[4][8];
  carry[6] = sum[5][8];
  Co = carry[7];
end

assign y = {sum[5:0], sum[7:6]};

endmodule