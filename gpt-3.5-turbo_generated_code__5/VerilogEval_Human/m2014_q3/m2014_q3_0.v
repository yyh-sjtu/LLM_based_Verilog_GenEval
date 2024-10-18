
module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		case (x)
			4'b0000 : f = 1; // case 00
			4'b0001 : f = 0; // case 01
			4'b0011 : f = 1; // case 11
			4'b0010 : f = 1; // case 10
			4'b01xx : f = 1; // x[3]=0
			4'b11xx : f = 0; // x[3]=1
			4'bxx00 : f = 0; // x[1:0]=00
			4'bxx01 : f = 1; // x[1:0]=01
			4'bxx11 : f = 1; // x[1:0]=11
			4'bxx10 : f = 0; // x[1:0]=10
			default: f = 0; // default
		endcase
	end

endmodule