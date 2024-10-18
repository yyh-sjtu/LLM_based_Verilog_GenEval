
module TopModule(
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

  // Define the states of the finite state machine
  parameter [1:0] IDLE = 2'b00;
  parameter [1:0] WALK_LEFT = 2'b01;
  parameter [1:0] WALK_RIGHT = 2'b10;
  
  // Define the current state and next state variables
  reg [1:0] state, next_state;

  // Define the internal signals
  reg fall, switch_direction;

  // Synchronous state machine
  always @(posedge clk) begin
    if (areset) begin
      // Asynchronous reset
      state <= IDLE;
    end else begin
      // State transition logic
      state <= next_state;
    end
  end

  // Combinational logic
  always @* begin
    // Default assignments
    next_state = state;
    aaah = 0;
    digging = 0;
    
    // State machine behavior
    case (state)
      IDLE: begin
        walk_left = 1;
        walk_right = 0;
        
        if (!ground) begin
          // If ground disappears, start falling (transition to WALK_LEFT)
          next_state = WALK_LEFT;
        end else if (dig && ground) begin
          // If requested to dig and on ground, start digging
          next_state = IDLE;
          digging = 1;
        end
      end
      
      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
        
        if (bump_right || (bump_left && !fall)) begin
          // If bumped on right or bumped on both sides when not falling, switch to WALK_RIGHT
          next_state = WALK_RIGHT;
        end else if (!ground) begin
          // If ground disappears, start falling (transition to IDLE)
          next_state = IDLE;
        end else if (dig && ground) begin
          // If requested to dig and on ground, start digging
          next_state = IDLE;
          digging = 1;
        end
      end
      
      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        
        if (bump_left || (bump_right && !fall)) begin
          // If bumped on left or bumped on both sides when not falling, switch to WALK_LEFT
          next_state = WALK_LEFT;
        end else if (!ground) begin
          // If ground disappears, start falling (transition to IDLE)
          next_state = IDLE;
        end else if (dig && ground) begin
          // If requested to dig and on ground, start digging
          next_state = IDLE;
          digging = 1;
        end
      end
    endcase
    
    // Fall behavior
    if (!ground && state != IDLE) begin
      fall = 1;
      aaah = 1;
    end else begin
      fall = 0;
    end
  end
  
endmodule