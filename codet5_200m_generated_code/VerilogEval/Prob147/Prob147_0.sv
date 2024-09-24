module TopModule (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg [1:0] state;
    always @(posedge clk)
        if (state == 1'b1)
            q <= a;
        else
            q <= b;
    assign state = a;
endmodule

