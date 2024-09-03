module
module FullAdder16 (
  input [15:0] a, // 16-bit input a
  input [15:0] b, // 16-bit input b
  input cin, // carry-in
  output reg [15:0] sum, // 16-bit sum
  output cout // carry-out
);

  reg [15:0] temp;
  reg c;

  always @* begin
    c = cin;
    for (int i = 0; i < 16; i = i + 1) begin
      temp[i] = a[i] ^ b[i] ^ c;
      c = (a[i] & b[i]) | (b[i] & c) | (a[i] & c);
    end
    sum = temp;
    cout = c;
  end

endmodule

module that counts from 0 through 9 when slowena is high
module DecadeCounter (
  input clk,
  input slowena,
  input reset,
  output [3:0] q
);

  reg [3:0] count;

  always @* begin
    if (reset) begin
      count <= 4'b0000;
    end else if (slowena) begin
      if (count == 4'b1001) begin
        count <= 4'b0000;
      end else begin
        count <= count + 4'b0001;
      end
    end
  end

  assign q = count;

endmodule

