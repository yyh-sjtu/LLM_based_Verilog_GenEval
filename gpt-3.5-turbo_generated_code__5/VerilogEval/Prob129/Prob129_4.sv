
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Define the states
  parameter s0 = 2'b00;
  parameter s1 = 2'b01;
  parameter s2 = 2'b11;

  // Declare the state register
  reg [1:0] state;

  // Declare the next state logic
  always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
      state <= s0; // Reset to initial state
    end
    else begin
      case (state)
        s0: begin
          if (x) begin
            state <= s1;
          end
          else begin
            state <= s0;
          end
        end

        s1: begin
          if (x) begin
            state <= s1;
          end
          else begin
            state <= s2;
          end
        end

        s2: begin
          if (x) begin
            state <= s1;
          end
          else begin
            state <= s2;
          end
        end
      endcase
    end
  end

  // Declare the output logic
  always @(state, x) begin
    if (state == s2 && !x) begin
      z <= 1'b1;
    end
    else begin
      z <= 1'b0;
    end
  end

endmodule