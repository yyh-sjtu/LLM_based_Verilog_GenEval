
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

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00; // Reset to walk left
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case (state)
      2'b00: begin // Walking left
        walk_left = 1'b1;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        if (bump_right && !bump_left) begin
          next_state = 2'b01; // Switch to walking right
        end else if (!ground) begin
          next_state = 2'b10; // Fall (aaah!)
        end else if (dig) begin
          next_state = 2'b11; // Start digging
        end else begin
          next_state = 2'b00; // Continue walking left
        end
      end
      2'b01: begin // Walking right
        walk_left = 1'b0;
        walk_right = 1'b1;
        aaah = 1'b0;
        digging = 1'b0;
        if (bump_left && !bump_right) begin
          next_state = 2'b00; // Switch to walking left
        end else if (!ground) begin
          next_state = 2'b10; // Fall (aaah!)
        end else if (dig) begin
          next_state = 2'b11; // Start digging
        end else begin
          next_state = 2'b01; // Continue walking right
        end
      end
      2'b10: begin // Falling
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b1;
        digging = 1'b0;
        if (ground) begin
          next_state = state; // Resume previous walking direction
        end else begin
          next_state = 2'b10; // Continue falling
        end
      end
      2'b11: begin // Digging
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b1;
        if (!ground) begin
          next_state = 2'b10; // Fall (aaah!) after digging
        end else if (bump_left && !bump_right) begin
          next_state = 2'b00; // Switch to walking left after digging
        end else if (bump_right && !bump_left) begin
          next_state = 2'b01; // Switch to walking right after digging
        end else begin
          next_state = 2'b11; // Continue digging
        end
      end
      default: begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;
      end
    endcase
  end

endmodule