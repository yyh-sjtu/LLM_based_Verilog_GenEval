
module TopModule (
  input [2:0] a,
  output reg [15:0] q
);

  always @*
    case(a)
      3'b000: q = 16'b0001001000110010; // 0x1232
      3'b001: q = 16'b1010111011100000; // 0xaee0
      3'b010: q = 16'b0010011110100100; // 0x27d4
      3'b011: q = 16'b0101101000001110; // 0x5a0e
      3'b100: q = 16'b0010000001100110; // 0x2066
      3'b101: q = 16'b0110010011001110; // 0x64ce
      3'b110: q = 16'b1100010100100110; // 0xc526
      3'b111: q = 16'b0010111100011001; // 0x2f19
      default: q = 16'b0000000000000000; // Default value for invalid input
    endcase

endmodule