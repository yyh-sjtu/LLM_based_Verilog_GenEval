
module TopModule (
  input clk,
  input areset,
  input in,
  output out
);

  reg [1:0] state;
  reg out_reg;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b1; // Reset to state B
    else begin
      case (state)
        2'b00: begin // State A
          if (in)
            state <= 2'b00; // Transition to state A
          else
            state <= 2'b01; // Transition to state B
        end
        2'b01: begin // State B
          if (in)
            state <= 2'b00; // Transition to state A
          else
            state <= 2'b01; // Transition to state B
        end
      endcase
    end
  end

  always @(state) begin
    case (state)
      2'b00: out_reg <= 1'b0; // Output 0 in state A
      2'b01: out_reg <= 1'b1; // Output 1 in state B
    endcase
  end

  assign out = out_reg;

endmodule