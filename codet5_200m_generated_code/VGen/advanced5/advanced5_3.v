module abro (
	input clk,
	input reset,
	input a,
	input b,
	output z
);
  reg [1:0] cur_state;
  reg [1:0] next_state;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cur_state <= IDLE;
      next_state <= SAB;
    end else begin
      if (a) begin
        cur_state <= SAB;
        next_state <= IDLE;
      end else begin
        cur_state <= next_state;
        next_state <= cur_state + 1;
      end
    end
  end
  assign z = cur_state == SAB;
endmodule

