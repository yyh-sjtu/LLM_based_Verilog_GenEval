module TopModule (
	input [7:0] in,
	output [7:0] out
);
    wire [7:0] code;
    assign out = code[7:0];
    always @ (in)
    begin
        code[7:0] = in[7:0];
    end
endmodule

