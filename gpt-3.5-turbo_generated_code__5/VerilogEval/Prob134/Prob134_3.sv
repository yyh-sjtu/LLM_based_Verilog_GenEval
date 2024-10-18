
module TopModule (
  input x,
  input [2:0] y,
  output Y0,
  output z
);

  reg [2:0] nextState;
  
  always @(*) begin
    case(y)
      3'b000: nextState = (x == 1'b0) ? 3'b001 : 3'b000;
      3'b001: nextState = (x == 1'b0) ? 3'b001 : 3'b100;
      3'b010: nextState = (x == 1'b0) ? 3'b001 : 3'b010;
      3'b011: nextState = (x == 1'b0) ? 3'b010 : 3'b001;
      3'b100: nextState = (x == 1'b0) ? 3'b100 : 3'b011;
    endcase
  end
  
  assign Y0 = nextState[0];
  assign z = (y == 3'b011) || (y == 3'b100);
  
endmodule