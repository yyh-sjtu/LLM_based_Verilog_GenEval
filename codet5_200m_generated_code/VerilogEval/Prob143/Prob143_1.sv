module TopModule (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2
);
    reg [9:0] next_code;
    reg [10:0] state_reg;
    wire [9:0] code_out;
    wire [9:0] code;
    assign out1 = code_out[9];
    assign out2 = code_out[8];
    assign code = state_reg[10:1];
    always @ (*)
    begin
        case(state)
            1'b1 : next_code = {9'b0, in};
            1'b10 : next_code = {9'b0, in};
            1'b11 : next_code = {9'b0, in};
            default : next_code = {9'b0, in};
        endcase
    end
    always @ (*)
    begin
        case(state)
            1'b1 : next_code = {9'b0, in};
            1'b10 : next_code = {9'b0, in};
            default : next_code = {9'b0, in};
        endcase
    end
endmodule

