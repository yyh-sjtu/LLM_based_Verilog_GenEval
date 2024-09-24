module TopModule (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2
);
    parameter [10:0] STATE_N = 2'b00;
    parameter [1:0] STATE_S = 2'b01;
    localparam STATE_P = (STATE_N >= 2'b10)? STATE_N - 2'b01 : STATE_N;
    localparam STATE_B = (STATE_N >= 2'b11)? STATE_N - 2'b10 : STATE_N;
    wire [11:0] Next_State;
    wire [11:0] Next_Code;
    assign Next_State = next_Code;
    assign Next_Code = Next_Code + 1;
    assign out1 = Next_State[0];
    assign out2 = Next_State[1];
    assign State = Next_State;
endmodule

