
module TopModule (
    input [7:0] in,
    output reg [31:0] out
);

always @(in) begin
    out = {{24{in[7]}}, in};
end

endmodule