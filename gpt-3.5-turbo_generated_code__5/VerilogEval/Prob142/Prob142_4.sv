
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

  // Define the states
  typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    AAH
  } State;

  // Define the current state variable
  reg [1:0] current_state;

  // Define the next state variable
  reg [1:0] next_state;

  // Define the output variables
  reg next_walk_left;
  reg next_walk_right;
  reg next_aaah;

  // Flip-flop to store the current state
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      current_state <= next_state;
    end
  end

  // Logic to compute the next state and outputs
  always @(current_state or bump_left or bump_right or ground) begin
    next_state = current_state;
    next_walk_left = walk_left;
    next_walk_right = walk_right;
    next_aaah = aaah;

    case (current_state)
      WALK_LEFT: begin
        if (bump_right) begin
          next_state = WALK_RIGHT;
          next_walk_left = 0;
          next_walk_right = 1;
        end else if (!ground) begin
          next_state = FALL;
          next_aaah = 1;
        end
      end

      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
          next_walk_left = 1;
          next_walk_right = 0;
        end else if (!ground) begin
          next_state = FALL;
          next_aaah = 1;
        end
      end

      FALL: begin
        if (ground) begin
          next_state = current_state;
          next_aaah = 0;
        end
      end
    endcase
  end

  // Update the outputs with the next values on the positive edge of the clock
  always @(posedge clk) begin
    walk_left <= next_walk_left;
    walk_right <= next_walk_right;
    aaah <= next_aaah;
  end

endmodule