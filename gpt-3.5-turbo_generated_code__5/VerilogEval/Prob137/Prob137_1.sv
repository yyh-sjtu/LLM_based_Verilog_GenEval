
module TopModule(
  input clk,
  input reset,
  input in,
  output reg done
);

  // FSM states
  typedef enum logic [2:0] {
    IDLE,
    START_WAIT,
    DATA_WAIT,
    STOP_WAIT
  } State;

  // Internal signals
  reg [2:0] state;
  reg start_detected;
  reg [7:0] data_counter;

  // Reset logic
  always @ (posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else
      state <= next_state;
  end

  // Combinational logic
  always @(*) begin
    done = (state == STOP_WAIT);
    start_detected = (state == DATA_WAIT);
  end

  // State transition and output logic
  always @ (posedge clk) begin
    if (reset) begin
      // Reset all internal registers
      state <= IDLE;
      data_counter <= 0;
    end
    else begin
      case (state)
        IDLE:
          if (!in)
            state <= START_WAIT;
        START_WAIT:
          if (in)
            state <= DATA_WAIT;
        DATA_WAIT:
          begin
            if (data_counter < 7)
              state <= DATA_WAIT;
            else
              state <= STOP_WAIT;
          end
        STOP_WAIT:
          begin
            if (!in)
              state <= START_WAIT;
            else if (start_detected)
              state <= DATA_WAIT;
          end
        default:
          state <= IDLE;
      endcase
      if (state == DATA_WAIT && !reset)
        data_counter <= data_counter + 1;
      else if (state == IDLE || state == START_WAIT || reset)
        data_counter <= 0;
    end
  end

endmodule