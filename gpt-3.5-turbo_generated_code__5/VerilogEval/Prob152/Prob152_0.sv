
module TopModule (
  input  clk,
  input  areset,
  input  bump_left,
  input  bump_right,
  input  ground,
  input  dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);

  // Enumerate the states of the finite state machine
  typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
  } StateType;

  // Define the state and next_state signals
  reg [2:0] state, next_state;

  // Next state logic
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end

  // State transition logic
  always @(state or bump_left or bump_right or ground or dig) begin
    next_state = state;

    case (state)
      WALK_LEFT:
        if (bump_right)
          next_state = WALK_RIGHT;
        else if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
      WALK_RIGHT:
        if (bump_left)
          next_state = WALK_LEFT;
        else if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
      FALL:
        if (ground)
          next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
      DIG:
        if (ground)
          next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
    endcase
  end

  // Output logic
  always @(state) begin
    case (state)
      WALK_LEFT:
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      WALK_RIGHT:
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      FALL:
        walk_left = state == WALK_LEFT;
        walk_right = state == WALK_RIGHT;
        aaah = 1;
        digging = 0;
      DIG:
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
    endcase
  end
endmodule