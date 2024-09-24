module TopModule (
    input clk,
    input reset,
    input w,
    output z
);
    reg [1:0] state;
    always @(posedge clk or posedge reset)
        if (reset)
            state <= 0;
        else
            if (w)
                state <= 1;
        else
                state <= 0;
    assign z = state[1];
endmodule

