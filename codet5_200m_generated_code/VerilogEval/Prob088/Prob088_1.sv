module TopModule (
    input clk,
    input areset,
    input x,
    output z
);
    parameter [1:0] INIT = 2'b00;
    parameter [1:0] WAIT = 2'b01;
    reg [1:0] state;
    reg [1:0] next_state;
    always @(posedge clk or posedge areset)
        if (areset)
            state <= INIT;
        else
            state <= next_state;
    always @(posedge clk or posedge areset)
        if (areset)
            next_state <= WAIT;
        else
            next_state <= next_state;
    assign z = state[1];
endmodule

