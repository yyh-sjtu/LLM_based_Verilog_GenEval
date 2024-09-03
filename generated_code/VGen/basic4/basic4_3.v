module mux(
    input [4:0] a, b,	// Input data lines
    input sel,		// Select line
    output reg [4:0] out	// Output data lines
);

always @(*) begin
    if (sel == 1'b0) 
        out = a;	// If select line is low, output is a
    else
        out = b;	// If select line is high, output is b
end

endmodule

