module pulse_detect (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // Enum representing the different states of pulse detection
  typedef enum logic [2:0] {
    IDLE,
    FIRST_HIGH,
    WAIT_LOW,
    SECOND_HIGH
  } State;

  reg [2:0] state;

  always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= IDLE;
      data_out <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (data_in) begin
            state <= FIRST_HIGH;
          end
        end
        FIRST_HIGH: begin
          if (!data_in) begin
            state <= WAIT_LOW;
          end
        end
        WAIT_LOW: begin
          if (data_in) begin
            state <= SECOND_HIGH;
          end
        end
        SECOND_HIGH: begin
          if (!data_in) begin
            state <= IDLE;
            data_out <= 1;
          end
        end
      endcase
    end
  end

endmodule

