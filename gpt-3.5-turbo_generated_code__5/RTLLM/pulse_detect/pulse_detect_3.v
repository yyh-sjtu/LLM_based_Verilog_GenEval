module pulse_detect (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);
  
  // State definition
  reg [2:0] state;
  
  // State parameters
  localparam IDLE = 3'd0;
  localparam PULSE_1 = 3'd1;
  localparam PULSE_2 = 3'd2;
  localparam PULSE_3 = 3'd3;
  
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= IDLE;
      data_out <= 0;
    end
    else begin
      case (state)
        IDLE: begin
          if (data_in) begin
            state <= PULSE_1;
          end
        end
        PULSE_1: begin
          if (!data_in) begin
            state <= PULSE_2;
          end
        end
        PULSE_2: begin
          if (data_in) begin
            state <= PULSE_3;
          end
        end
        PULSE_3: begin
          if (!data_in) begin
            state <= IDLE;
            data_out <= 1;
          end
        end
        default: begin
          state <= IDLE;
          data_out <= 0;
        end
      endcase
    end
  end  
endmodule

