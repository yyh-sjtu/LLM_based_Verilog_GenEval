
module div_16bit (
  input [15:0] A,
  input [7:0] B,
  output reg [15:0] result,
  output reg [15:0] odd
);

  reg [15:0] a_reg;
  reg [7:0] b_reg;
  reg [15:0] rem;
  
  always @* begin
    a_reg = A;
    b_reg = B;
  end
  
  always @* begin
    rem = A;
    result = 16'h0000;
    odd = 16'h0000;
    
    for (i = 15; i >= 8; i = i - 1) begin
      if (rem[i] == 1) begin
        rem = rem - (b_reg << (i - 8));
        result[i] = 1;
      end
    end
    
    for (i = 7; i >= 0; i = i - 1) begin
      if (rem[i] == 1) begin
        odd[i] = 1;
        break;
      end
    end
  end
endmodule