module truthtable (
	input x3,
	input x2,
	input x1,
	output f
);
    reg [7:0] t;
    always @(x3 or x2 or x1)
    begin
        if (x3)
            t = 7'b0000001;
        else
            t = 7'b0000000;
    end
    assign f = t[7];
endmodule

