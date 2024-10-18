
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg f, g;

  reg [2:0] state;
  reg [2:0] x_history;
  reg [1:0] y_count;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 3'b000; // Reset state A
      f <= 1'b0;
      g <= 1'b0;
      x_history <= 3'b000;
      y_count <= 2'b00;
    end else begin
      case (state)
        3'b000: begin // State A
          if (resetn) begin
            f <= 1'b0;
            g <= 1'b0;
          end
          if (x && !x_history && !f) begin
            state <= 3'b001; // Transition to state B
            f <= 1'b1;
          end
        end

        3'b001: begin // State B
          if (resetn) begin
            f <= 1'b0;
            g <= 1'b0;
          end
          if (x && !x_history && f) begin
            state <= 3'b010; // Transition to state C
            g <= 1'b1;
            y_count <= 2'b00;
          end
        end

        3'b010: begin // State C
          if (resetn) begin
            f <= 1'b0;
            g <= 1'b0;
          end
          if (y && g && (y_count == 2'b00)) begin
            y_count <= 2'b01;
          end else if (!y && g && (y_count == 2'b01)) begin
            y_count <= 2'b10;
          end else if (!y && g && (y_count == 2'b10)) begin
            y_count <= 2'b00;
            g <= 1'b0;
          end
        end

        default: begin // Reset state A
          state <= 3'b000;
          f <= 1'b0;
          g <= 1'b0;
          x_history <= 3'b000;
          y_count <= 2'b00;
        end
      endcase
    end
    x_history <= {x_history[1:0], x}; // Shift new x value into the history register
  end

endmodule