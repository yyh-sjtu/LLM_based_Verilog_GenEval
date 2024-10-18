
module TopModule (
  input clk,
  input reset,
  input in,
  output done
);

// Define states for the finite state machine
typedef enum { IDLE, START_BIT, DATA_BITS, STOP_BIT } state_t;

reg [2:0] state;
reg done;

// Define constants for start and stop bits
parameter START_BIT_VALUE = 1'b0;
parameter STOP_BIT_VALUE  = 1'b1;

always @(posedge clk) begin
  if (reset) begin
    // Reset the FSM
    state <= IDLE;
    done <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        if (in == START_BIT_VALUE) begin
          // Start bit detected, transition to the next state
          state <= START_BIT;
        end
      end
      
      START_BIT: begin
        // Wait for all 8 data bits
        state <= DATA_BITS;
      end
      
      DATA_BITS: begin
        // Verify stop bit
        if (in == STOP_BIT_VALUE) begin
          // Stop bit detected, byte received successfully
          state <= STOP_BIT;
          done <= 1'b1;
        end
      end
      
      STOP_BIT: begin
        // Expecting the line to be idle (1) for the next byte
        if (in == 1'b1) begin
          // Transition back to IDLE state
          state <= IDLE;
          done <= 1'b0;
        end
      end
    endcase
  end
end

endmodule