
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  always @* begin
    case ({a, b, c, d, e})
      4'b00000 : q = b;
      4'b00001 : q = e;
      4'b00010 : q = a;
      4'b00011 : q = d;
      4'b00100 : q = 4'b1111; // f in binary
      4'b00101 : q = 4'b1111; // f in binary
      4'b00110 : q = 4'b1111; // f in binary
      4'b00111 : q = 4'b1111; // f in binary
      4'b01000 : q = 4'b1111; // f in binary
      4'b01001 : q = 4'b1111; // f in binary
      4'b01010 : q = 4'b1111; // f in binary
      4'b01011 : q = 4'b1111; // f in binary
      4'b01100 : q = 4'b1111; // f in binary
      4'b01101 : q = 4'b1111; // f in binary
      4'b01110 : q = 4'b1111; // f in binary
      4'b01111 : q = 4'b1111; // f in binary
      default : q = 4'b1111; // f in binary
    endcase
  end

endmodule