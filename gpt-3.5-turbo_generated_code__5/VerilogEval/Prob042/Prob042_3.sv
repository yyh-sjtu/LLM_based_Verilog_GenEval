
module TopModule (
    input [7:0] in,
    output reg [31:0] out
);

// Sign Bit Extension
wire [31:0] sign_extended;
assign sign_extended = {24 {in[7]}, in};

// Output assignment
always @(in)
begin
    out <= sign_extended;
end

endmodule