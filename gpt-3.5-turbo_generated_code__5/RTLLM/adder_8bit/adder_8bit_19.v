module adder_8bit (
  input [7:0] a,
  input [7:0] b,
  input cin,
  output reg [7:0] sum,
  output reg cout
);

  wire [7:0] carry; // Carry signals between full adders

  // A series of bit-level adders (full adders) to perform 8-bit addition
  // Here I am using a for loop to instantiate 8 full adders
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : full_adder_inst
      full_adder full_adder_inst (
        .a(a[i]),
        .b(b[i]),
        .cin(i == 0 ? cin : carry[i-1]), // The carry-in is the cin for the first full adder, and the carry-out from the previous full adder for the rest
        .sum(sum[i]),
        .cout(carry[i])
      );
    end
  endgenerate

  assign cout = carry[7]; // The carry-out from the last full adder is the overall carry-out
endmodule

module full_adder (
  input a,
  input b,
  input cin,
  output reg sum,
  output reg cout
);
  // Logic to determine sum and carry-out
  always @* begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (cin & (a ^ b));
  end
endmodule

