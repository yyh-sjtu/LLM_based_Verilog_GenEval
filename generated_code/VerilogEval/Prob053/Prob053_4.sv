
module TopModule (
    input clk,
    input in,
    output reg out
);

reg ff_input;
reg ff_output;

assign out = ff_output;

always @(posedge clk) begin
    ff_input <= in ^ ff_output;
    ff_output <= ff_input;
end

endmodule