module TopModule (
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output [3:0] q
);
    reg [3:0] q;
    always @(posedge clk or posedge areset)
        if (areset)
            q <= 4'b0000;
        else if (load)
            q <= data;
    always @(posedge clk or posedge areset)
        if (areset)
            q <= 4'b0000;
        else if (load)
            q <= data;
    assign q = q >> 1;
endmodule

