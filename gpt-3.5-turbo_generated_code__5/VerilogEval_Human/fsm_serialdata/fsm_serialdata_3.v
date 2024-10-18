module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

parameter START = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;
reg [1:0] state;
reg [7:0] rx_data;
reg done;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= START;
		rx_data <= 8'b0;
		next_state <= START;
		done <= 0;
	end
	
	else begin
		state <= next_state;
		rx_data <= {rx_data[6:0], in};
		done <= 0;
		
		case (state)
			START: begin
				if (in == 1'b0)
					next_state <= DATA;
				else
					next_state <= START;
			end
			
			DATA: begin
				if (in == 1'b0)
					next_state <= DATA;
				else
					next_state <= STOP;
			end
			
			STOP: begin
				if (in == 1'b1) begin
					next_state <= START;
					done <= 1;
				end
				else
					next_state <= START;
			end
		endcase
	end
end

assign out_byte = rx_data;

endmodule

