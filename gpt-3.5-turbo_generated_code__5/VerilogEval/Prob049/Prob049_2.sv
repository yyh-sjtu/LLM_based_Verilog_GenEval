
module TopModule (
    input clk,
    input ar,
    input d,
    output reg q
);

always @(posedge clk or negedge ar)
begin
    if (!ar)
        q <= 1'b0; // asynchronous reset
    else
        q <= d; // D flip flop behavior on positive clock edge
end

endmodule