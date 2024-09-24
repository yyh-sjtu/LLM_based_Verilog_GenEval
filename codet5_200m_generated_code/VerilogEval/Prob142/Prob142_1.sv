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
    parameter IDLE = 0;
    parameter ADD = 1;
    parameter SUB = 2;
    parameter IN_2_1 = 3'b000;
    parameter IN_2_2 = 3'b001;
    parameter SUB_2 = 3'b010;
    parameter DIV = 4'b001;
    parameter DIV_2 = 3'b011;
    parameter DIV_2 = 3'b100;
    parameter DIV_2 = 3'b101;
    parameter DIV_2 = 3'b110;
    parameter DIV_2 = 3'b111;
    reg [3:0] next_state;
    wire [3:0] state = next_state;
    wire [3:0] prev_state;
    assign prev_state = state[3:0];
    assign walk_left = state[3] == IDLE;
    assign walk_right = state[3] == ADD;
    assign aaah = state[3] == SUB;
    wire [3:0] code = (state == DIV_2)? code : 1'b0;
    always @(posedge clk) begin
        if(reset)
            next_state <= IDLE;
        else if(!areset &&!bump_left)
            next_state <= SUB;
        else if(bump_right && ground)
            next_state <= SUB_2_1;
        else if (state == DIV_2_1)
            next_state <= SUB_2_2;
        else
            next_state <= IDLE;
    end
    always @(posedge clk) begin
        if(~areset)
            next_state <= IDLE;
        else if(state == IN_2_1)
            next_state <= SUB_2;
    end
endmodule

