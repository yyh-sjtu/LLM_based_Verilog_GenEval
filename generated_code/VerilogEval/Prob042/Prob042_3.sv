
module SignExtender (
    input [7:0] in,
    output reg [31:0] out
);

reg [7:0] sign; // sign bit (MSB) of the input number

// Determine the sign bit of the input number
always @* begin
    sign = in[7];
end

// Perform sign extension by replicating the sign bit 24 times
always @* begin
    out = { {24 {sign}}, in };
end

endmodule