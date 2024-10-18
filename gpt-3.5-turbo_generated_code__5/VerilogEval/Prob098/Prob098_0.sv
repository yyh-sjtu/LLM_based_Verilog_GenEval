
module TopModule(
    input clk,
    input a,
    output reg q
);

// D flip-flop implementation
always @(posedge clk)
begin
    q <= a;
end

endmodule