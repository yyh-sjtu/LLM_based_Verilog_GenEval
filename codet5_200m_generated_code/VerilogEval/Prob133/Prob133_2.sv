module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output z
);
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    parameter E = 4;
    parameter F = 5;
    parameter G = 6;
    parameter H = 7;
    parameter S = 8;
    parameter W = 9;
    reg [1:0] state;
    reg [1:0] next_state;
    always @(posedge clk)
        if (reset)
            state <= A;
        else
            state <= next_state;
    always @(posedge clk)
        if (reset)
            next_state <= A;
        else
            next_state <= next_state;
    assign z = state == B? 1'b0 : state == C? 1'b1 : state == E? 1'b0 : state == F? 1'b1 : state == G? 1'b0 : state == S? 1'b1 : state == H? 1'b0 : state == S? 1'b1 : state == E? 1'b0 : state == S? 1'b1 : state == H? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b0 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state == S? 1'b1 : state ;
endmodule

