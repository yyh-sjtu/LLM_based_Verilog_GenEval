
module TopModule (
  input clk,
  input areset,
  input in,
  output reg out
);

  reg [1:0] state, next_state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // Reset to state A
    else
      state <= next_state;
  end

  always @(state or in) begin
    case (state)
      2'b00: begin // State A
        if (in)
          next_state = 2'b01; // Next state if in=1
        else
          next_state = 2'b10; // Next state if in=0
        out = 1'b0; // Output for state A
      end

      2'b01: begin // State B
        if (in)
          next_state = 2'b01; // Next state if in=1
        else
          next_state = 2'b11; // Next state if in=0
        out = 1'b0; // Output for state B
      end

      2'b10: begin // State C
        if (in)
          next_state = 2'b00; // Next state if in=1
        else
          next_state = 2'b11; // Next state if in=0
        out = 1'b0; // Output for state C
      end

      2'b11: begin // State D
        if (in)
          next_state = 2'b10; // Next state if in=1
        else
          next_state = 2'b01; // Next state if in=0
        out = 1'b1; // Output for state D
      end
    endcase
  end

endmodule