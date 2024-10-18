
module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

// Define states for the finite state machine
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;

reg [1:0] state;
reg [3:0] data_counter;
reg [7:0] data_reg;

always @ (posedge clk or posedge reset)
begin
	if (reset) begin
		state <= IDLE;
		data_counter <= 0;
		data_reg <= 0;
		out_byte <= 0;
		done <= 0;
	end
	else begin
		case (state)
			IDLE: begin
				if (in == 1)
					state <= START_BIT;
			end
			START_BIT: begin
				if(data_counter < 8) begin
					data_reg <= {data_reg[6:0], in};
					data_counter <= data_counter + 1;
				end
				else begin
					state <= DATA_BITS;
					data_counter <= 0;
				end
			end
			DATA_BITS: begin
				if(data_counter < 7) begin
					data_reg <= {data_reg[6:0], in};
					data_counter <= data_counter + 1;
				end
				else begin
					if(in == 1)
						begin
							out_byte <= data_reg;
                                                        done <= 1;
							state <= START_BIT;
						end
					else
						state <= IDLE;
				end
			end
		endcase
	end
end

endmodule