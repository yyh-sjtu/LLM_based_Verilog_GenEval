
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire data,
  input  wire done_counting,
  input  wire ack,
  output wire shift_ena,
  output wire counting,
  output wire done
);

  // Define the states for the finite-state machine
  typedef enum logic [2:0] {
    START,
    SHIFT_IN,
    WAIT_COUNTING,
    NOTIFY,
    WAIT_ACK
  } StateType;

  // Define the state register
  reg StateType state, next_state;

  // Define the output register
  reg shift_ena_reg, counting_reg, done_reg;

  // Sequential logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= START;
      shift_ena_reg <= 1'b0;
      counting_reg <= 1'b0;
      done_reg <= 1'b0;
    end else begin
      state <= next_state;
      shift_ena_reg <= shift_ena_reg;
      counting_reg <= counting_reg;
      done_reg <= done_reg;
    end
  end

  // Combinational logic
  always @(*) begin
    next_state = state;
    shift_ena = shift_ena_reg;
    counting = counting_reg;
    done = done_reg;

    case (state)
      START: begin
        if (data == 1'b1) begin
          next_state = SHIFT_IN;
          shift_ena = 1'b1;
        end
      end

      SHIFT_IN: begin
        if (data == 1'b0) begin
          next_state = WAIT_COUNTING;
          shift_ena = 1'b0;
          counting = 1'b1;
        end
      end

      WAIT_COUNTING: begin
        if (done_counting == 1'b1) begin
          next_state = NOTIFY;
          counting = 1'b0;
          done = 1'b1;
        end
      end

      NOTIFY: begin
        if (ack == 1'b1) begin
          next_state = WAIT_ACK;
          done = 1'b0;
        end
      end

      WAIT_ACK: begin
        if (ack == 1'b0) begin
          next_state = START;
        end
      end
    endcase
  end

endmodule