module TopModule (
	input clk,
	input reset,
	input [31:0] in,
	output [31:0] out
);
    reg [31:0] out_reg;
    always @(posedge clk)
    begin
        if(reset)
            out_reg <= 32'h0;
        else
            out_reg <= out_reg;
    end
    always @(posedge clk)
    begin
        out <= out_reg;
    end
endmodule

