
module TopModule(
  input [6:0] y,
  input w,
  output Y1,
  output Y3
);
  wire Y2, Y4;
  reg [6:0] nextState;
  
  always @* begin
    case (y)
      7'b0000001: nextState = 7'b0000001; // A
      7'b0000010: nextState = 7'b0000011; // B
      7'b0000100: nextState = 7'b0001001; // C
      7'b0001000: nextState = 7'b0000111; // D
      7'b0010000: nextState = 7'b0001011; // E
      7'b0100000: nextState = 7'b0010111; // F
      default    : nextState = 7'b0000001; // Default to A on reset
    endcase
  end
  
  assign Y2 = nextState[1];
  assign Y4 = nextState[3];
  
  assign Y1 = (y[0] & ~y[1]) | (y[0] & y[2]) | (y[0] & y[3]);
  assign Y3 = (~y[0] & y[3]) | (y[0] & y[4]) | (y[0] & y[5]);
  
endmodule