
module TopModule (
    input [15:0] in,
    output reg [7:0] out_lo,
    output reg [7:0] out_hi
);

always @* begin
    out_lo = in[7:0];
    out_hi = in[15:8];
end

endmodule