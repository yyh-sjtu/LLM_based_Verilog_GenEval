
module TopModule (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg q_next, state_next;

  always @(posedge clk) begin
    q <= q_next;
    state <= state_next;
  end

  always @* begin
    case (state)
      0: begin
        if (a & b)
          {q_next, state_next} = 2'b10;
        else
          {q_next, state_next} = 2'b00;
      end
      1: begin
        if (!a & b)
          {q_next, state_next} = 2'b01;
        else
          {q_next, state_next} = 2'b00;
      end
      default: begin
        {q_next, state_next} = 2'b00;
      end
    endcase
  end

endmodule