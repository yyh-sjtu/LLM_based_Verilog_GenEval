
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);

  reg [4:0] counter;  // Counter to keep track of falling time

  // Enumerated type for FSM states
  typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG,
    SPLATTER
  } State;

  State state, next_state;  // State variables

  // State machine logic
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end

  // Next state and output logic
  always @(state or bump_left or bump_right or ground or dig) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
      WALK_LEFT: begin
        if (bump_right)
          next_state = WALK_RIGHT;
        else if (dig)
          next_state = DIG;
        else if (!ground)
          next_state = FALL;
        walk_left = 1;
      end

      WALK_RIGHT: begin
        if (bump_left)
          next_state = WALK_LEFT;
        else if (dig)
          next_state = DIG;
        else if (!ground)
          next_state = FALL;
        walk_right = 1;
      end

      FALL: begin
        if (counter >= 20)
          next_state = SPLATTER;
        else if (ground)
          next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
        else
          counter <= counter + 1;
        aaah = 1;
      end

      DIG: begin
        if (!ground)
          next_state = FALL;
        else if (dig)
          next_state = DIG;
        else if (counter >= 20)
          next_state = SPLATTER;
        else
          digging = 1;
      end

      SPLATTER: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
    endcase
  end

endmodule