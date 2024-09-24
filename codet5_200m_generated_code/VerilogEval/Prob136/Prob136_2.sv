module TopModule (
	input clk,
	input reset,
	input w,
	output z
);
    reg [3:0] state;
    reg [3:0] state_next;
    reg [3:0] code;
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            state_next <= 3'b000;
            code <= 3'b001;
        end else if(w) begin
            case(state)
                3'b000: begin
                    code <= 3'b001;
                    state_next <= 3'b010;
                end
                3'b010: begin
                    code <= 3'b010;
                    state_next <= 3'b011;
                end
                3'b011: begin
                    code <= 3'b100;
                    state_next <= 3'b101;
                end
                3'b111: begin
                    code <= 3'b100;
                    state_next <= 3'b101;
                end
                3'b100: begin
                    code <= 3'b101;
                    state_next <= 3'b101;
                end
                3'b101: begin
                    code <= 3'b101;
                    state_next <= 3'b111;
                end
                3'b111: begin
                    code <= 3'b111;
                    state_next <= 3'b111;
                end
            endcase
        end
    end
    assign z = code;
endmodule

