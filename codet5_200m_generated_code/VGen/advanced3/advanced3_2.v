module adv_fsm(
    input clk,
    input reset,
    input x,
    output z
);
parameter IDLE = 0; 
parameter S1 = 1; 
parameter S10 = 2; 
parameter S101 = 3; 
reg [1:0] present_state; 
reg [1:0] next_state; 
always @(posedge clk)
begin
  if (reset)
    present_state <= IDLE;
  else
    if (x)
      present_state <= S1;
  else
      present_state <= next_state;
end
assign z = (present_state == S101);
endmodule

