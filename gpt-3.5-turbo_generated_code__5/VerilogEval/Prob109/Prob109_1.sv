module TopModule(
  input  clk,
  input  areset,
  input  in,
  output out
);

  reg state;
  reg next_state;

  always @(posedge clk or negedge areset) begin
    if (areset)
      state <= 1'b1; // Reset asynchronously to state B
    else
      state <= next_state;
  end

  always @(state, in) begin
    case (state)
      1'b0: begin
        next_state = in; // A (0) --1--> A
        out = 1'b0; // A (0) --0--> B
      end
      1'b1: begin
        next_state = in; // B (1) --1--> B
        out = 1'b1; // B (1) --0--> A
      end
    endcase
  end

endmodule

