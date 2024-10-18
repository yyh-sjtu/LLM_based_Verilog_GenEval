module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
always @* begin
    case ({a, b, c, d, e})
        // If a = b and c = 0, q = b
        {4'b0000, 4'b0000}: q = b;
        // If a = b and c = 1, q = e
        {4'b0000, 4'b0001}: q = e;
        // If a = b and c = 2, q = a
        {4'b0000, 4'b0010}: q = a;
        // If a = b and c = 3, q = d
        {4'b0000, 4'b0011}: q = d;
        // If a = b and c = 4, q = f
        {4'b0000, 4'b0100}: q = f;
        // If a = b and c = 5, q = f
        {4'b0000, 4'b0101}: q = f;
        // If a = b and c = 6, q = f
        {4'b0000, 4'b0110}: q = f;
        // If a = b and c = 7, q = f
        {4'b0000, 4'b0111}: q = f;
        // If a = b and c = 8, q = f
        {4'b0000, 4'b1000}: q = f;
        // If a = b and c = 9, q = f
        {4'b0000, 4'b1001}: q = f;
        // If a = b and c = a, q = f
        {4'b0000, 4'b1010}: q = f;
        // If a = b and c = b, q = f
        {4'b0000, 4'b1011}: q = f;
        // If a = b and c = c, q = f
        {4'b0000, 4'b1100}: q = f;
        // If a = b and c = d, q = f
        {4'b0000, 4'b1101}: q = f;
        // If a = b and c = e, q = f
        {4'b0000, 4'b1110}: q = f;
        // If a = b and c = f, q = f
        {4'b0000, 4'b1111}: q = f;
        default: q = 4'bxxxx;
    endcase
end
endmodule

