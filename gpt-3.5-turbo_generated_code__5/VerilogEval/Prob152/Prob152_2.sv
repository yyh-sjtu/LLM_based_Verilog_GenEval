
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

  // Define states
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;
  parameter FALLING = 2'b10;
  parameter DIGGING = 2'b11;

  // Define internal state variable
  reg [1:0] state;

  // Define output signals
  assign aaah = (state == FALLING);
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset the state machine to walk left
      state <= WALK_LEFT;
      walk_left <= 1'b1;
      walk_right <= 1'b0;
      digging <= 1'b0;
    end else begin
      // Update state based on inputs
      case (state)
        WALK_LEFT: begin
          if (bump_right) begin
            state <= WALK_RIGHT;
            walk_left <= 1'b0;
            walk_right <= 1'b1;
            digging <= 1'b0;
          end else if (dig && ground) begin
            state <= DIGGING;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b1;
          end else if (!ground) begin
            state <= FALLING;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
          end
        end
        WALK_RIGHT: begin
          if (bump_left) begin
            state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            digging <= 1'b0;
          end else if (dig && ground) begin
            state <= DIGGING;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b1;
          end else if (!ground) begin
            state <= FALLING;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
          end
        end
        FALLING: begin
          if (ground) begin
            state <= walk_left ? WALK_LEFT : WALK_RIGHT;
            walk_left <= walk_left;
            walk_right <= walk_right;
            digging <= 1'b0;
          end
        end
        DIGGING: begin
          if (!ground) begin
            state <= FALLING;
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            digging <= 1'b0;
          end
        end
      endcase
    end
  end

endmodule