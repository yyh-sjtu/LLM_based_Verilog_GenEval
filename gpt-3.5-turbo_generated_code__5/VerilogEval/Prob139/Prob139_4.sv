
module TopModule (
  input  clk,
  input  resetn,
  input  x,
  input  y,
  output f,
  output g
);

  reg [1:0] state;
  reg       f_reg;
  reg       g_reg;

  always @(posedge clk) begin
    if (!resetn) begin
      state <= 2'b00; // State A
      f_reg <= 1'b0;
      g_reg <= 1'b0;
    end
    else begin
      case (state)
        2'b00: begin // State A
          f_reg <= 1'b1;
          state <= 2'b01; // Transition to State B
        end
        2'b01: begin // State B
          if (x == 1'b1) begin
            state <= 2'b10; // Transition to State C
          end
        end
        2'b10: begin // State C
          if (x == 1'b0) begin
            state <= 2'b01; // Transition back to State B
          end
          else if (y == 1'b1) begin
            g_reg <= 1'b1;
            state <= 2'b11; // Transition to State D
          end
        end
        2'b11: begin // State D
          if (y == 1'b0) begin
            state <= 2'b00; // Transition back to State A
            g_reg <= 1'b0;
          end
        end
      endcase
    end
  end

  assign f = f_reg;
  assign g = g_reg;

endmodule