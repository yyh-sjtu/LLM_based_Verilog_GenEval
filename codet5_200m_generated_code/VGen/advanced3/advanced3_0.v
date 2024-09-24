module adv_fsm(
    input clk,
    input reset,
    input x,
    output z
);
parameter IDLE = 2'b00; 
parameter S1 = 2'b01; 
parameter S10 = 2'b10; 
parameter S101 = 2'b11; 
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
        if (x)
            present_state <= S1;
            next_state <= S10;
            next_state <= S101;
        end
end
assign z = (present_state == S101);
endmodule

