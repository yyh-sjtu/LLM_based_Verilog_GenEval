
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Define the states
  localparam A = 1'b0;
  localparam B = 1'b1;

  // Define the signals and registers
  reg [2:0] counter;
  reg state;

  // Sequential logic
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      counter <= 3'b0;
    end else begin
      case(state)
        A: begin
          if (s) begin
            state <= B;
            counter <= 0;
          end
        end
        B: begin
          counter <= counter + 1;
          if (counter == 3) begin
            if ((w == 1'b1) && ((counter[0] && !counter[1] && counter[2]) || (!counter[0] && counter[1] && counter[2]) || (counter[0] && counter[1] && !counter[2]) || (counter[0] && counter[1] && counter[2]))) begin
              z <= 1;
            end else begin
              z <= 0;
            end
            counter <= 0;
          end
        end
      endcase
    end
  end

endmodule