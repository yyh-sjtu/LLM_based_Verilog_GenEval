module top_module (
	input clk,
	input in,
	input reset,
	output done
);

// Define the states of the finite state machine
enum { IDLE, START_BIT, DATA_BITS, STOP_BIT } state;

// Define the number of data bits and stop bit
parameter DATA_BITS_NUM = 8;
parameter STOP_BIT_NUM = 1;

// Define the signals
reg [3:0] current_state;
reg [DATA_BITS_NUM-1:0] data_bits_reg;
reg [DATA_BITS_NUM-1:0] data_bits;
reg stop_bit_reg;
reg stop_bit;

// Output done signal when a byte is correctly received
assign done = (current_state == STOP_BIT);

// Synchronous reset
always @(posedge clk) begin
	if (reset)
		current_state <= IDLE;
	else
		current_state <= state;
end

// Identify when bytes have been correctly received
always @(posedge clk) begin
	case (current_state)
		IDLE:
			if (in == 0)
				state = START_BIT;
			else
				state = IDLE;
		
		START_BIT:
			if (in == 1)
				state = DATA_BITS;
			else
				state = START_BIT;
		
		DATA_BITS:
			data_bits_reg <= {data_bits_reg[DATA_BITS_NUM-2:0], in};
			
			if (data_bits_reg == DATA_BITS_NUM'b1)
				state = STOP_BIT;
			else
				state = DATA_BITS;
		
		STOP_BIT:
			stop_bit_reg <= in;
			
			if (stop_bit_reg == STOP_BIT_NUM'b1)
				state = IDLE;
			else
				state = STOP_BIT;
	endcase
end

// Update the data_bits and stop_bit signals
always @(posedge clk) begin
	if (current_state == DATA_BITS)
		data_bits <= data_bits_reg;
	else
		data_bits <= 'b0;
	
	if (current_state == STOP_BIT)
		stop_bit <= stop_bit_reg;
	else
		stop_bit <= 'b0;
end

endmodule

