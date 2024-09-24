module TopModule (
	input [6:0] y,
	input w,
	output Y1,
	output Y3
);
    localparam S1 = 0;
    localparam S2 = 1;
    reg [1:0] state;
    initial begin
        state <= S1;
    end
    always @(y)
    begin
        case (state)
            S1:
                state <= S2;
            S2:
                state <= S1;
        endcase
    end
    assign Y1 = y[0];
    assign Y3 = y[1];
endmodule

