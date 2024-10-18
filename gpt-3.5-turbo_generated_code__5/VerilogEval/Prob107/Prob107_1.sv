
module TopModule (
  input clk,
  input reset,
  input in,
  output reg out
);

  // Define the states of the Moore state machine
  enum {A, B} state;
  
  // Define the next state logic
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= B;
    else
    begin
      case (state)
        B: state <= (in) ? B : A;
        A: state <= (in) ? A : B;
      endcase
    end
  end
  
  // Define the output logic based on the current state
  always @(state)
  begin
    case (state)
      B: out <= 1;
      A: out <= 0;
    endcase
  end

endmodule