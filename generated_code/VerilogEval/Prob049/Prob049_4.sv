
module TopModule (
    input clk,
    input ar,
    input d,
    output reg q
);

// D flip flop with positive edge-triggered clock and asynchronous reset
always @(posedge clk or posedge ar)
begin
    if(ar)
        q <= 1'b0; // Reset the output q to 0
    else
        q <= d; // Update the output q with the input d on positive clock edge
end

endmodule