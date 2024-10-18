
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

// Decade counter logic
always @(posedge clk or posedge reset)
begin
    if (reset)
        q <= 4'b0000;
    else if (q == 4'b1001)
        q <= 0;
    else
        q <= q + 1;
end

endmodule