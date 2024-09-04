
module TopModule (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_next;

always @(posedge clk) begin
    q <= q_next;
end

always @* begin
    q_next = d;
end

endmodule