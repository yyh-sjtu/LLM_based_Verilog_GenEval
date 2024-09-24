module TopModule (
	input clk,
	input areset,
	input [7:0] d,
	output [7:0] q
);
    parameter WIDTH = 8;
    parameter DEPTH = 32;
    wire [WIDTH-1:0] out;
    assign q = out;
    reg [WIDTH-1:0] out_reg;
    always @ (posedge clk or negedge areset) begin
        if (areset)
            out_reg <= 8'h00;
        else if (out_reg == 8'h00)
            out_reg <= 8'h01;
        else if (out_reg == 8'h01)
            out_reg <= 8'h0;
    end
endmodule

