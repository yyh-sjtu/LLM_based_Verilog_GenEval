module TopModule (
    input [7:0] in,
    output reg [7:0] out
);

always @(*) begin
    for (int i = 0; i < 8; i = i + 1) begin
        out[i] = in[7 - i];
    end
end

endmodule

