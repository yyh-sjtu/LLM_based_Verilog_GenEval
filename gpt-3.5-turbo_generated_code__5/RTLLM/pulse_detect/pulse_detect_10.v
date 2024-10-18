
module pulse_detect (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // Declare state register
  reg [2:0] state;

  // Define states
  parameter IDLE = 3'b000;
  parameter FIRST_HIGH = 3'b001;
  parameter FIRST_LOW = 3'b010;
  parameter SECOND_HIGH = 3'b011;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= IDLE;
      data_out <= 0;
    end
    else begin
      case (state)
        IDLE: begin
          if (data_in) begin
            state <= FIRST_HIGH;
          end
        end
        FIRST_HIGH: begin
          if (!data_in) begin
            state <= FIRST_LOW;
          end
        end
        FIRST_LOW: begin
          if (data_in) begin
            state <= SECOND_HIGH;
          end
        end
        SECOND_HIGH: begin
          if (!data_in) begin
            state <= IDLE;
            data_out <= 1;
          end
          else begin
            data_out <= 0;
          end
        end
        default: state <= IDLE;
      endcase
    end
  end

endmodule