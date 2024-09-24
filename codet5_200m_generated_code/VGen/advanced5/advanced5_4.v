module abro (
	input clk,
	input reset,
	input a,
	input b,
	output z
);
  parameter IDLE = 0;
  parameter SA = 1;
  parameter SB = 2;
  parameter SAB = 3;
  reg [1:0] cur_state;
  reg [1:0] next_state;
  assign z = cur_state[1];
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cur_state <= IDLE;
      next_state <= SA;
    end else begin
      if (a) begin
        cur_state <= SA;
        next_state <= SB;
      end else begin
        if (b) begin
            next_state <= SAB;
            cur_state <= SAB;
        end
      end
    end
  end
endmodule

