
module TopModule (
  input  clk,
  input  areset,
  input  bump_left,
  input  bump_right,
  output reg walk_left,
  output reg walk_right
);

  // Define the states
  localparam [1:0] WALK_LEFT = 2'b00;
  localparam [1:0] WALK_RIGHT = 2'b01;

  // Define the signals for the current state and next state
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Moore state machine logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset the machine to walk left
      current_state <= WALK_LEFT;
    end else begin
      // Transition to next state based on inputs
      current_state <= next_state;
    end
  end

  // Next state and output logic
  always @(current_state, bump_left, bump_right) begin
    case (current_state)
      WALK_LEFT:
        if (bump_right) begin
          next_state <= WALK_RIGHT;
        end else begin
          next_state <= WALK_LEFT;
        end
      WALK_RIGHT:
        if (bump_left) begin
          next_state <= WALK_LEFT;
        end else begin
          next_state <= WALK_RIGHT;
        end
    endcase
  end

  // Output assignment
  always @(current_state) begin
    case (current_state)
      WALK_LEFT:
        begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
        end
      WALK_RIGHT:
        begin
          walk_left <= 1'b0;
          walk_right <= 1'b1;
        end
    endcase
  end

endmodule