
module TopModule(
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

  // Define the states of the finite state machine
  // 0 - Walking Left
  // 1 - Walking Right
  // 2 - Falling
  // 3 - Digging
  reg [1:0] state;
  
  // Counter to keep track of the fall duration
  reg [4:0] fall_counter;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset: Lemming machine starts by walking left
      state <= 0;
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
      fall_counter <= 0;
    end else begin
      // Sequential logic for the finite state machine
      case(state)
        0: begin // Walking Left
          if (bump_left == 1) begin
            state <= 1; // Switch to Walking Right
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
            fall_counter <= 0;
          end else if (ground == 0) begin
            state <= 2; // Start Falling
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            fall_counter <= 1;
          end else if (dig == 1 && fall_counter == 0) begin
            state <= 3; // Start Digging
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
            fall_counter <= 0;
          end
        end
        1: begin // Walking Right
          if (bump_right == 1) begin
            state <= 0; // Switch to Walking Left
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall_counter <= 0;
          end else if (ground == 0) begin
            state <= 2; // Start Falling
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            fall_counter <= 1;
          end else if (dig == 1 && fall_counter == 0) begin
            state <= 3; // Start Digging
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
            fall_counter <= 0;
          end
        end
        2: begin // Falling
          if (ground == 1) begin
            state <= 0; // Walk in the same direction as before falling
            walk_left <= (walk_right == 1) ? 0 : 1;
            walk_right <= (walk_right == 1) ? 1 : 0;
            aaah <= 0;
            digging <= 0;
            fall_counter <= 0;
          end else begin
            state <= 2; // Continue Falling
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            fall_counter <= (fall_counter == 20) ? 20 : fall_counter + 1;
          end
        end
        3: begin // Digging
          if (ground == 0) begin
            state <= 2; // Start Falling
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
            fall_counter <= 1;
          end else if (dig == 0) begin
            state <= 0; // Stop Digging, continue walking
            walk_left <= (walk_right == 1) ? 0 : 1;
            walk_right <= (walk_right == 1) ? 1 : 0;
            aaah <= 0;
            digging <= 0;
            fall_counter <= 0;
          end else begin
            state <= 3; // Continue Digging
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
            fall_counter <= 0;
          end
        end
      endcase
    end
  end

endmodule