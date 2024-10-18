
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [5:0] out_not
);
  
  always @* begin
    out_or_bitwise = a | b;
    out_or_logical = a || b;
    out_not[5:3] = ~b;
    out_not[2:0] = ~a;
  end
  
endmodule