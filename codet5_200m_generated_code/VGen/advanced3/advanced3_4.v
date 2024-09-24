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
    begin
        present_state <= IDLE;
        next_state <= IDLE;
    end
    else
    begin
        if (x == 1)
            present_state <= S1;
        else
            present_state <= S10;
        else
            present_state <= S101;
    end
end
assign z = (present_state == S101);
endmodule

