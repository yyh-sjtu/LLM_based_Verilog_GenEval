module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	reg [31:0] shift_register;
	reg [31:0] twos_complement;
	reg enable_conversion;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= 2'b00;
			shift_register <= 0;
			twos_complement <= 0;
		end else if (enable_conversion) begin
			case (state)
				2'b00: begin
					state <= 2'b01;
					shift_register <= {shift_register[30:0], x};
					twos_complement <= 0;
				end

				2'b01: begin
					if (shift_register[31] == 1) begin
						state <= 2'b10;
						shift_register <= ~shift_register + 1;
						twos_complement <= shift_register;
					end else begin
						state <= 2'b01;
						shift_register <= {shift_register[30:0], x};
					end
				end

				2'b10: begin
					state <= 2'b00;
					twos_complement <= shift_register;
				end
			endcase
		end else begin
			state <= 2'b00;
			shift_register <= 0;
			twos_complement <= 0;
		end
	end

	assign z = twos_complement;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			enable_conversion <= 0;
		end else if (enable_conversion && state == 2'b10) begin
			enable_conversion <= 0;
		end else if (!enable_conversion && !areset) begin
			enable_conversion <= 1;
		end
	end

endmodule

