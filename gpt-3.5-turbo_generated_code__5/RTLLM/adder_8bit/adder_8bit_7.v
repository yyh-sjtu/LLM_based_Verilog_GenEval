module adder_8bit (
    input [7:0] a,
    input [7:0] b,
  input cin,
  output reg [7:0] sum,
  output reg cout
);

reg [7:0] carry;
reg [7:0] sum_internal;

initial begin
  carry[0] = cin;
  sum_internal[0] = a[0] ^ b[0] ^ cin; // initial sum
  for (i = 1; i < 8; i = i + 1) begin
    carry[i] = (a[i]&b[i]) | (a[i]&carry[i-1]) | (b[i]&carry[i-1]);
    sum_internal[i] = a[i] ^ b[i] ^ carry[i-1];
  end
end

always @(*) begin
  sum = sum_internal;
  cout = carry[7];
end

endmodule

