
module TopModule (
  input clk,
  input areset,
  input in,
  output reg out
);

  // State declaration
  reg [1:0] state;

  // State definitions
  parameter A = 2'b00;
  parameter B = 2'b01;

  // Output logic
  always @(state)
    case (state)
      A: out = 1'b0;
      B: out = 1'b1;
    endcase

   // State transitions
   always @(posedge clk or posedge areset)
    if (areset)
      state <= B;
    else
      case (state)
        A: state <= in ? A : B;
        B: state <= in ? A : B;
      endcase

endmodule