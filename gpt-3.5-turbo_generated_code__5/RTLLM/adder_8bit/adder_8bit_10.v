module adder_8bit (
  input [7:0] a,
  input [7:0] b,
  input cin,
  output [7:0] sum,
  output cout
);

  // Declare internal wire connections
  wire [7:0] carry;
  wire [7:0] sum_temp;

  // Utilize a series of 8 full adders for 8-bit addition
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin: full_adder_gen
      full_adder FA (.a(a[i]), .b(b[i]), .cin(carry[i]), .sum(sum_temp[i]), .cout(carry[i+1]));
    end
  endgenerate

  // Assign the carry-out output
  assign cout = carry[8];

  // Assign the sum output
  assign sum = sum_temp;

endmodule

