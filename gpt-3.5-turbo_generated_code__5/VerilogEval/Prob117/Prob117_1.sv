
module TopModule (
    input clk,
    input a,
    output reg [2:0] q
);

reg [2:0] q_next;

always @(posedge clk) begin
    if (a == 0)
        q_next = 0;
    else if (q == 4)
        q_next = 5;
    else if (q == 5)
        q_next = 6;
    else if (q == 6)
        q_next = 0;
    else
        q_next = q;
end

always @(posedge clk) begin
    q <= q_next;
end

endmodule