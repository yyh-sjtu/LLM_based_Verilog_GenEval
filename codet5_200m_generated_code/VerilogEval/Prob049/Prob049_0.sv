module TopModule (
	input clk,
	input ar,
	input d,
	output q
);
    reg [7:0] d_reg;
    always @ (posedge clk or posedge ar) begin
        if (ar)
            d_reg <= 0;
        else
            d_reg <= d;
    end
    assign q = d_reg[7];
endmodule

