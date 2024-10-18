
module adder_8bit(
  input wire a,
  input wire b,
  input wire Cin,
  output wire y,
  output wire Cout
);

  assign {Cout, y} = a + b + Cin;

endmodule

module adder_16bit(
  input wire [15:0] a,
  input wire [15:0] b,
  input wire Cin,
  output wire [15:0] y,
  output wire Co
);

  wire [7:0] carry; // Carry-out from each 8-bit adder
  wire [7:0] sum;   // Sum output from each 8-bit adder

  adder_8bit u0 (
    .a(a[7:0]),
    .b(b[7:0]),
    .Cin(Cin),
    .y(y[7:0]),
    .Cout(carry[0])
  );
  adder_8bit u1 (
    .a(a[15:8]),
    .b(b[15:8]),
    .Cin(carry[0]),
    .y(y[15:8]),
    .Cout(carry[1])
  );

  genvar i;
  generate
    for (i = 2; i < 8; i = i + 1) begin : ADDER_LOOP
      adder_8bit u (
        .a(a[i*8-1:i*8-8]),
        .b(b[i*8-1:i*8-8]),
        .Cin(carry[i-1]),
        .y(y[i*8-1:i*8-8]),
        .Cout(carry[i])
      );
    end
  endgenerate

  assign Co = carry[7];

endmodule