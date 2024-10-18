
module TopModule (
    input [99:0] in,
    output [99:0] out
);

// Logic for reversing the bit ordering
always @* begin
    for (int i = 0; i < 100; i++) begin
        out[i] = in[99 - i];
    end
end

endmodule