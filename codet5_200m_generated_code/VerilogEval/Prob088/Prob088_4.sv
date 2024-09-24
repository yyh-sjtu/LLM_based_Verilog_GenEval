module TopModule (
    input clk,
    input areset,
    input x,
    output z
);
    parameter [1:0] INIT = 2'b00;
    parameter [1:0] WAIT = 2'b01;
    reg [1:0] state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= INIT;
        else
            state <= state + 1'b1;
    assign z = state[1];
endmodule

