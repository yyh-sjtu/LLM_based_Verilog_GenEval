
module pulse_detect (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // Declare state register
  reg [2:0] state;

  // Initial state assignments
  localparam IDLE = 3'b000;
  localparam STATE_1 = 3'b001;
  localparam STATE_2 = 3'b010;
  localparam STATE_3 = 3'b011;

  // Always block for pulse detection logic
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= IDLE;
      data_out <= 0;
    end else begin
      case(state)
        IDLE: begin
          if (data_in) begin
            state <= STATE_1;
          end
        end
        STATE_1: begin
          if (!data_in) begin
            state <= STATE_2;
          end
        end
        STATE_2: begin
          if (data_in) begin
            state <= STATE_3;
          end
        end
        STATE_3: begin
          if (!data_in) begin
            data_out <= 1;
            state <= IDLE;
          end else begin
            state <= STATE_1;
          end
        end
      endcase
    end
  end

endmodule