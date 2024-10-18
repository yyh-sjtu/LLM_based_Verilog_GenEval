module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

  // Define states
  parameter IDLE = 0;
  parameter WALK_LEFT = 1;
  parameter WALK_RIGHT = 2;
  parameter FALLING = 3;

  // Define current state and next state variables
  reg [1:0] state, next_state;

  // Define outputs
  reg [1:0] output;

  // Define internal variables
  wire hit_left, hit_right;
  reg fall_flag;

  // Synchronous reset
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end

  // Next state logic
  always @*
  begin
    case(state)
      IDLE:
        if (bump_left && bump_right)
          next_state = WALK_RIGHT;
        else if (bump_left)
          next_state = WALK_RIGHT;
        else if (bump_right)
          next_state = WALK_LEFT;
        else if (!ground)
          next_state = FALLING;
        else
          next_state = WALK_LEFT;

      WALK_LEFT:
        if (bump_right)
          next_state = WALK_RIGHT;
        else if (!ground)
          next_state = FALLING;
        else
          next_state = WALK_LEFT;

      WALK_RIGHT:
        if (bump_left)
          next_state = WALK_LEFT;
        else if (!ground)
          next_state = FALLING;
        else
          next_state = WALK_RIGHT;

      FALLING:
        if (ground)
          next_state = output;
        else
          next_state = FALLING;
    endcase
  end

  // Output logic
  always @*
  begin
    case(state)
      IDLE:
        output = WALK_LEFT;
        aaah = 0;
      
      WALK_LEFT:
        output = WALK_LEFT;
        aaah = 0;

      WALK_RIGHT:
        output = WALK_RIGHT;
        aaah = 0;

      FALLING:
        output = state;
        aaah = 1;
    endcase

    walk_left = output == WALK_LEFT;
    walk_right = output == WALK_RIGHT;
  end

endmodule

