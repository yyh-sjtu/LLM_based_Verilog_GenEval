
module TopModule (
  input clk,
  input areset,
  input j,
  input k,
  output reg out
);

  // Define the states of the Moore state machine
  parameter OFF = 1'b0;
  parameter ON = 1'b1;

  // Define the state register
  reg [1:0] state;

  // Define the next state logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      case (state)
        OFF: begin
          if (j) begin
            state <= ON;
          end else begin
            state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            state <= OFF;
          end else begin
            state <= ON;
          end
        end
      endcase
    end
  end

  // Define the output logic
  always @(state) begin
    case (state)
      OFF: begin
        out <= 1'b0;
      end
      ON: begin
        out <= 1'b1;
      end
    endcase
  end

endmodule