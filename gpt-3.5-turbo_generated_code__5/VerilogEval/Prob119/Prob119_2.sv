
module TopModule (
  input clk,
  input areset,
  input in,
  output reg out
);

  reg [1:0] state, next_state;

  // Sequential logic triggered on positive edge of clock
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00; // Reset to state A
    end else begin
      state <= next_state;
    end
  end

  // Combinational logic for state transitions and output generation
  always @* begin
    case (state)
      2'b00: begin // State A
        if (in) begin
          next_state = 2'b01; // Next state is B
        end else begin
          next_state = 2'b00; // Next state is A
        end
        out = 1'b0; // Output is 0 in state A
      end
      2'b01: begin // State B
        if (in) begin
          next_state = 2'b01; // Next state is B
        end else begin
          next_state = 2'b10; // Next state is C
        end
        out = 1'b0; // Output is 0 in state B
      end
      2'b10: begin // State C
        if (in) begin
          next_state = 2'b11; // Next state is D
        end else begin
          next_state = 2'b00; // Next state is A
        end
        out = 1'b0; // Output is 0 in state C
      end
      2'b11: begin // State D
        if (in) begin
          next_state = 2'b01; // Next state is B
        end else begin
          next_state = 2'b10; // Next state is C
        end
        out = 1'b1; // Output is 1 in state D
      end
    endcase
  end

endmodule