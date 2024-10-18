
module TopModule (
  input clk,
  input reset,
  input data,
  input done_counting,
  input ack,
  output reg shift_ena,
  output reg counting,
  output reg done
);

  enum logic [2:0] states;
  reg [3:0] shift_in;
  reg [3:0] delay;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      states <= 3'b001; // Initial state
    end else begin
      case (states)
        3'b001: begin // State 1 - Searching for start sequence 1101
          if (data == 4'b1101) begin
            states <= 3'b010;
          end else begin
            states <= 3'b001;
          end
        end
          
        3'b010: begin // State 2 - Shifting in 4 bits for delay
          shift_in <= {shift_in[2:0], data};
          
          if (shift_ena) begin
            states <= 3'b011;
            delay <= shift_in;
          end else begin
            states <= 3'b010;
          end
        end
          
        3'b011: begin // State 3 - Waiting for counters to finish
          if (done_counting) begin
            states <= 3'b100;
          end else begin
            states <= 3'b011;
          end
        end
          
        3'b100: begin // State 4 - Timer timed out
          if (ack) begin
            states <= 3'b001;
          end else begin
            states <= 3'b100;
          end
        end
      endcase
    end
  end

  always_comb begin
    case (states)
      3'b001: begin
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
      end
        
      3'b010: begin
        shift_ena <= 1'b1;
        counting <= 1'b0;
        done <= 1'b0;
      end
        
      3'b011: begin
        shift_ena <= 1'b0;
        counting <= 1'b1;
        done <= 1'b0;
      end
        
      3'b100: begin
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b1;
      end
    endcase
  end

endmodule