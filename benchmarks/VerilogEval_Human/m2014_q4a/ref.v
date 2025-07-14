module reference_module (
	input d,
	input ena,
	output logic q
);


	always@(*) begin
		if (ena)
			q = d;
	end

endmodule
