module TopModule (
	input d,
	input ena,
	output q
);
    reg [7:0] q;
    initial q = 'd;
    always @(ena)
    begin
        if (ena)
            q <= 'd;
    end
endmodule

