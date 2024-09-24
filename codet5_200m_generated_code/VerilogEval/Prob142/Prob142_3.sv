module TopModule (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);
parameter NUM_BULSE = 15;
parameter S_IN_0 = 1'b0;
parameter S_IN_1 = 1'b1;
parameter S_IN_2 = 1'b0;
parameter S_IN_3 = 1'b1;
reg [NUM_BULSE-1:0] current_state;
assign walk_left = current_state!= S_IN_0;
assign walk_right = current_state!= S_IN_1;
assign aaah = current_state == S_IN_2;
always @(posedge clk)
    begin
        current_state <= current_state + 1;
    end
reg [NUM_BULSE-1:0] current_state_next;
reg [NUM_BULSE-1:0] current_state_next_next;
wire [NUM_BULSE-1:0] current_state_next_next;
assign current_state = current_state_next;
always @(posedge clk)
    begin
        current_state_next_next <= current_state_next_next;
        current_state_next_next <= current_state;
    end
always @(posedge clk)
    begin
        current_state_next <= current_state + 1;
    end
always @(posedge clk)
    begin
        current_state_next_next <= current_state + 1;
    end
always @(posedge clk)
    begin
        current_state <= current_state + 1;
    end
always @(posedge clk)
    begin
        bump_right <= bump_right;
        bump_left <= bump_left;
        bump_left_next <= bump_left;
        bump_right_next <= bump_right;
        case(current_state)
            S_IN_0:
                begin
                    current_state_next <= S_IN_1;
                    bump_right <= bump_right;
                    current_state <= S_IN_2;
                end
            S_IN_1:
                begin
                    current_state_next <= S_IN_3;
                    bump_left <= bump_left;
                    bump_right <= bump_right;
                end
            S_IN_2:
                begin
                    current_state_next <= S_IN_3;
                    bump_left_next <= bump_left;
                    bump_right_next <= bump_right;
                end
            S_IN_3:
                begin
                    current_state_next <= S_IN_4;
                    bump_left <= bump_left;
                    bump_right <= bump_right;
                end
        endcase
    end
endmodule

