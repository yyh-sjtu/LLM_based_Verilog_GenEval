
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  // Define states
  localparam [1:0] START_STATE = 2'b00;
  localparam [1:0] F_SET_STATE = 2'b01;
  localparam [1:0] G_MONITOR_STATE = 2'b10;
  localparam [1:0] G_SET_STATE = 2'b11;

  // Define state register
  reg [1:0] state_reg, state_next;

  // Define count register for monitoring x
  reg [2:0] x_count_reg, x_count_next;

  // Define count register for monitoring y
  reg [1:0] y_count_reg, y_count_next;

  // Define reset synchronizer
  reg reset_sync;

  always @(posedge clk) begin
    // Synchronization for reset
    reset_sync <= resetn;

    if (reset_sync == 1'b0) begin
      // Initial state on reset
      state_reg <= START_STATE;
      f <= 1'b0;
      g <= 1'b0;
      x_count_reg <= 3'b0;
      y_count_reg <= 2'b0;
    end else begin
      // State transition logic
      state_reg <= state_next;
      x_count_reg <= x_count_next;
      y_count_reg <= y_count_next;
    end
  end

  always @(*) begin
    // Next state logic
    case (state_reg)
      START_STATE: begin
        state_next = F_SET_STATE;
      end
      
      F_SET_STATE: begin
        if (x == 1'b1) begin
          state_next = G_MONITOR_STATE;
        end else begin
          state_next = F_SET_STATE;
        end
      end
      
      G_MONITOR_STATE: begin
        if (x == 1'b0) begin
          x_count_next = x_count_reg + 1'b1;
        end else begin
          x_count_next = 3'b0;
        end
        
        if (x_count_reg == 3'b001 && (x == 1'b1)) begin
          state_next = G_SET_STATE;
        end else begin
          state_next = G_MONITOR_STATE;
        end
      end
      
      G_SET_STATE: begin
        if (y == 1'b1) begin
          y_count_next = y_count_reg + 1'b1;
        end else begin
          y_count_next = 2'b0;
        end
        
        if (y_count_reg == 2'b01 && (y == 1'b1)) begin
          g = 1'b1;
        end else begin
          g = 1'b0;
        end
        
        state_next = G_SET_STATE;
      end
    endcase
  end

endmodule