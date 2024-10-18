
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

  // State definition
  typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
  } State;

  // Internal signals
  reg [1:0] curr_state;
  reg [1:0] next_state;

  // State register
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      curr_state <= WALK_LEFT;
    end else begin
      curr_state <= next_state;
    end
  end

  // Next state logic
  always @(*) begin
    case (curr_state)

      WALK_LEFT: begin
        if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (dig && ground) begin
          next_state = DIG;
        end else if (!ground) begin
          next_state = FALL;
        end else begin
          next_state = WALK_LEFT;
        end
      end

      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (dig && ground) begin
          next_state = DIG;
        end else if (!ground) begin
          next_state = FALL;
        end else begin
          next_state = WALK_RIGHT;
        end
      end

      FALL: begin
        if (ground) begin
          next_state = curr_state;
        end else begin
          next_state = FALL;
        end
      end

      DIG: begin
        if (ground) begin
          next_state = WALK_LEFT; // Continue walking in original direction after fall
        end else begin
          next_state = DIG;
        end
      end

      default: next_state = WALK_LEFT;

    endcase
  end

  // Output logic
  always @(curr_state) begin
    case (curr_state)

      WALK_LEFT: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end

      WALK_RIGHT: begin
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      end

      FALL: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
      end

      DIG: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
      end

      default: begin
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end

    endcase
  end

endmodule