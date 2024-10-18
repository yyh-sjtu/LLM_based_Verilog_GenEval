module adder_16bit (
  input [15:0] a,
  input [15:0] b,
  input Cin,
  output [15:0] y,
  output Co
);

  wire [7:0] carry;
  wire [7:0] sum;

  // 8-bit adder instances
  adder_8bit half_adder_0 (.a(a[7:0]), .b(b[7:0]), .Cin(Cin), .y(sum[0]), .Co(carry[0]));
  adder_8bit half_adder_1 (.a(a[8:15]), .b(b[8:15]), .Cin(carry[0]), .y(sum[8]), .Co(carry[1]));

  // Carry-out calculation
  assign Co = carry[7];

  // Concatenating sum bits to get 16-bit output
  assign y = {sum[7], sum[6], sum[5], sum[4], sum[3], sum[2], sum[1], sum[0], sum[15], sum[14], 
              sum[13], sum[12], sum[11], sum[10], sum[9], sum[8]};

endmodule

