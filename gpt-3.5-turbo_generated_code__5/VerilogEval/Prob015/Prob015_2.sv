
module TopModule (
    input [15:0] in,
    output reg [7:0] out_hi,
    output reg [7:0] out_lo
);

assign out_hi = in[15:8];
assign out_lo = in[7:0];

endmodule