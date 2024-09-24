
module TopModule (
    input clk,
    input x,
    output z
);

// D Flip-Flop outputs
reg ff_xor_out;
reg ff_and_out;
reg ff_or_out;

// Output of the D flip-flops (complemented)
wire ff_xor_out_n = ~ff_xor_out;
wire ff_and_out_n = ~ff_and_out;
wire ff_or_out_n = ~ff_or_out;

// XOR Gate (connecting x and ff_xor_out)
wire xor_out = x ^ ff_xor_out;

// AND Gate (connecting x and complemented ff_and_out)
wire and_out = x & ff_and_out_n;

// OR Gate (connecting x and complemented ff_or_out)
wire or_out = x | ff_or_out_n;

// D Flip-Flops update on rising edge of clock
always @(posedge clk) begin
    ff_xor_out <= xor_out;  // DFF for XOR output
    ff_and_out <= and_out;   // DFF for AND output
    ff_or_out <= or_out;     // DFF for OR output
end

// XNOR output combining the three DFF outputs
assign z = ff_xor_out ^ ff_and_out ^ ff_or_out;

endmodule