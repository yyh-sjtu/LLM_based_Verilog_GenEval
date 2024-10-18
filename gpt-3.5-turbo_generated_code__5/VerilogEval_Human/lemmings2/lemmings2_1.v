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
   
   // State definitions
   parameter [1:0] WALK_LEFT = 2'b00;
   parameter [1:0] WALK_RIGHT = 2'b01;
   parameter [1:0] FALL = 2'b10;
   
   // Variables
   reg [1:0] state;
   
   // Reset on positive edge of areset signal
   always @(posedge areset) begin
      state <= WALK_LEFT;
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
   end
   
   // State transition and output logic
   always @(posedge clk) begin
      case (state)
         WALK_LEFT: begin
            if (bump_right == 1 && bump_left == 0) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
               aaah <= 0;
            end
            else if (bump_right == 1 && bump_left == 1) begin
               state <= WALK_RIGHT;
               walk_left <= 0;
               walk_right <= 1;
               aaah <= 0;
            end
            else if (ground == 0) begin
               state <= FALL;
               walk_left <= 0;
               walk_right <= 0;
               aaah <= 1;
            end
         end
         
         WALK_RIGHT: begin
            if (bump_left == 1 && bump_right == 0) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
               aaah <= 0;
            end
            else if (bump_left == 1 && bump_right == 1) begin
               state <= WALK_LEFT;
               walk_left <= 1;
               walk_right <= 0;
               aaah <= 0;
            end
            else if (ground == 0) begin
               state <= FALL;
               walk_left <= 0;
               walk_right <= 0;
               aaah <= 1;
            end
         end
         
         FALL: begin
            if (ground == 1) begin
               if (state == WALK_LEFT) begin
                  walk_left <= 1;
                  walk_right <= 0;
               end
               else if (state == WALK_RIGHT) begin
                  walk_left <= 0;
                  walk_right <= 1;
               end
               aaah <= 0;
               state <= WALK_LEFT;
            end
         end
      endcase
   end
endmodule

