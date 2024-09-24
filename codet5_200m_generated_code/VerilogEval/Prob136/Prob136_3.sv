module TopModule (
	input clk,
	input reset,
	input w,
	output z
);
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    parameter E = 4;
    parameter F = 5;
    reg [1:0] state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
            state <= A;
        else if (w)
            state <= B;
    end
    always @ (posedge clk)
    begin
        if (w)
            z <= state[1];
        else if (w)
            z <= state[0];
    end
endmodule

