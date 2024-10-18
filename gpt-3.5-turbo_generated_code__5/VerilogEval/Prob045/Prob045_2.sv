
module TopModule (
    input clk,
    input [7:0] in,
    input [7:0] anyedge,
    output reg [7:0] out
);

reg [7:0] prev_in;

always @(posedge clk) begin
    prev_in <= in;
    out <= (in & ~prev_in) & anyedge;
end

endmodule