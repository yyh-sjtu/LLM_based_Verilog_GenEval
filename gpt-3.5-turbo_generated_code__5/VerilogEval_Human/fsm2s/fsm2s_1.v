module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
 
reg [1:0] state, next_state;
 
parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= OFF;
    end else begin
        state <= next_state;
    end
end

always @* begin
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

