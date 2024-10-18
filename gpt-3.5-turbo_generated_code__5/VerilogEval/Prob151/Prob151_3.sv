
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire data,
  input  wire done_counting,
  input  wire ack,
  output reg shift_ena,
  output reg counting,
  output reg done
);

  // Define the states of the state machine
  localparam IDLE = 2'b00;
  localparam DETECT_PATTERN = 2'b01;
  localparam WAIT_COUNTING = 2'b10;
  localparam NOTIFY_DONE = 2'b11;

  // Internal signals and registers
  reg [1:0] state;

  // Sequential logic
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data) begin
            // Detected first '1' of the pattern
            state <= DETECT_PATTERN;
          end
        end
        DETECT_PATTERN: begin
          if (data) begin
            // Detected second '1' of the pattern
            state <= WAIT_COUNTING;
            shift_ena <= 1;
          end else begin
            // Go back to IDLE state if the pattern is not completed
            state <= IDLE;
          end
        end
        WAIT_COUNTING: begin
          if (done_counting) begin
            // Counting finished, notify the user
            state <= NOTIFY_DONE;
            counting <= 1;
          end
        end
        NOTIFY_DONE: begin
          if (ack) begin
            // User acknowledged the timer, go back to IDLE state
            state <= IDLE;
            done <= 1;
          end
        end
      endcase
    end
  end

endmodule