
module pulse_detect (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  typedef enum logic [2:0] {
    IDLE_STATE,
    FIRST_HIGH_STATE,
    SECOND_HIGH_STATE,
    THIRD_HIGH_STATE
  } state_t;

  reg [2:0] state;

  always @(posedge clk or negedge rst_n)
  begin
    if (~rst_n) begin
      state <= IDLE_STATE;
      data_out <= 0;
    end
    else begin
      case(state)
        IDLE_STATE:
          if (data_in) begin
            state <= FIRST_HIGH_STATE;
          end
        FIRST_HIGH_STATE:
          if (~data_in) begin
            state <= SECOND_HIGH_STATE;
          end
        SECOND_HIGH_STATE:
          if (data_in) begin
            state <= THIRD_HIGH_STATE;
          end
        THIRD_HIGH_STATE:
          if (~data_in) begin
            state <= IDLE_STATE;
            data_out <= 1;
          end
      endcase
    end
  end

endmodule