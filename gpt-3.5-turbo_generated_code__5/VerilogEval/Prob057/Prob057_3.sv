
module TopModule (
  input  wire a,
  input  wire b,
  input  wire c,
  input  wire d,
  output reg out
);
  
  always @* begin
    case({c, d})
      2'b00: out = a & b;
      2'b01: out = a & ~b;
      2'b11: out = ~a | b;
      2'b10: out = a ^ b;
    endcase
  end
  
endmodule