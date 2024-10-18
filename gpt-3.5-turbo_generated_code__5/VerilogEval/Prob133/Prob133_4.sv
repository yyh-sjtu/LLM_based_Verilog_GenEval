
module TopModule (
  input        clk,
  input        reset,
  input        s,
  input        w,
  output reg   z
);

  // Define the states
  reg [1:0] state;

  // Assign the initial state
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b0;  // Reset state A
    else
      state <= next_state;
  end

  // Determine the next state based on current state and inputs
  reg [2:0] next_state;

  always @(state, w) begin
    case (state)
      2'b00: begin  // State A
        if (s)
          next_state <= 2'b01;  // Transition to state B when s = 1
        else
          next_state <= 2'b00;  // Stay in state A
      end

      2'b01: begin  // State B
        if (w == 2'b01 || w == 2'b10 || w == 2'b11)
          next_state <= 2'b10;  // Transition to state C when w = 1 in exactly two of the next three clock cycles
        else
          next_state <= 2'b01;  // Stay in state B
      end

      2'b10: begin  // State C
        if (w == 2'b10 || w == 2'b01 || w == 2'b11)
          next_state <= 2'b01;  // Transition to state B when w = 1 in exactly two of the next three clock cycles
        else
          next_state <= 2'b10;  // Stay in state C
      end
    endcase
  end

  // Determine the value of output z based on state
  always @(state) begin
    if (state == 2'b10)
      z <= 1'b1;  // Set output z to 1 in state C
    else
      z <= 1'b0;  // Set output z to 0 in other states
  end

endmodule