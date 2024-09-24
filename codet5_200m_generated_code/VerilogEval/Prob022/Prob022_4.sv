module TopModule (
	input a,
	input b,
	input sel,
	output out
);
    reg [1:0] out_bit;
    assign out = out_bit[sel];
    initial
        out_bit = 'bx;
    always @(a or b or sel)
    begin
        case (sel)
            0: out_bit = 'bx;
            1: out_bit = 'bx;
            default: out_bit = 'bx;
        endcase
    end
endmodule

