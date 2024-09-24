module TopModule (
	input d,
	input ena,
	output q
);
    reg [1:0] code;
    always @ (d or ena)
    begin
        if (ena)
            code <= #1 1'b1;
        else
            code <= #1 code + 1'b1;
    end
    assign q = code[0];
endmodule

