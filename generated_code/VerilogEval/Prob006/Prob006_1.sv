
module TopModule(
    input [7:0] in,
    output reg [7:0] out
);

always @(*) begin
    out = 8'b0; // Initialize output to 0
    for (int i = 0; i < 8; i = i+1) begin
        out[i] = in[7-i]; // Reverse bit ordering of input and write to output
    end
end

endmodule