module top_module (
	input clk,
	input in,
	input reset,
	output done
);
  	reg [3:0] state;
  	reg [7:0] received_byte;
  	reg [3:0] bit_counter;
  	
  	parameter START_BIT = 0;
  	parameter DATA_BIT = 1;
  	parameter STOP_BIT = 2;
  	
  	assign done = (state == STOP_BIT);
  	
  	always @(posedge clk or posedge reset) begin
  		if (reset) begin
  			state <= START_BIT;
  			received_byte <= 8'b0;
  			bit_counter <= 4'b0;
  		end
  		else begin
  			case (state)
  				START_BIT:
  					if (in == 0) begin
  						state <= DATA_BIT;
  						received_byte <= 8'b0;
  						bit_counter <= 4'b0;
  					end
  				DATA_BIT:
  					if (bit_counter == 4'b1000) begin
  						state <= STOP_BIT;
  					end
  					else begin
  						received_byte <= {received_byte[6:0], in};
  						bit_counter <= bit_counter + 1;
  					end
  				STOP_BIT:
  					if (in == 1) begin
  						state <= START_BIT;
  					end
  			endcase
  		end
  	end
endmodule

