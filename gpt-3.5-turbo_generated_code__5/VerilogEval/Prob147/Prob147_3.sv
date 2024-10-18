
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q_reg;
  reg state_reg;

  always @(posedge clk) begin
    case({state_reg, a, b})
      3'b000: begin
        q_reg <= 0;
        state_reg <= 0;
      end
      3'b001: begin
        q_reg <= 0;
        state_reg <= 0;
      end
      3'b010: begin
        q_reg <= 0;
        state_reg <= 0;
      end
      3'b011: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      3'b100: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      3'b101: begin
        q_reg <= 1;
        state_reg <= 0;
      end
      3'b110: begin
        q_reg <= 0;
        state_reg <= 1;
      end
      3'b111: begin
        q_reg <= 0;
        state_reg <= 0;
      end
      default: begin
        q_reg <= 0;
        state_reg <= 0;
      end
    endcase
  end

  assign q = q_reg;
  assign state = state_reg;

endmodule