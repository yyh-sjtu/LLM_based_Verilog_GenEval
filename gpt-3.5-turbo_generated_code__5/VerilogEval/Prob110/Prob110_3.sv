
module TopModule (
  input clk,
  input areset,
  input j,
  input k,
  output reg out
);

  enum {OFF, ON} state;
  reg next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      state <= next_state;
    end
  end

  always @(state or j or k) begin
    case(state)
      OFF: begin
        if (j) begin
          next_state = ON;
          out = 1'b0;
        end else begin
          next_state = OFF;
          out = 1'b0;
        end
      end
      ON: begin
        if (k) begin
          next_state = OFF;
          out = 1'b1;
        end else begin
          next_state = ON;
          out = 1'b1;
        end
      end
    endcase
  end

endmodule