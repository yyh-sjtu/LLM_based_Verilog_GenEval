module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Logic for turning on ringer or motor based on input conditions
always @ (ring, vibrate_mode)
begin
	if (vibrate_mode == 1) begin
		// Vibrate mode, turn on motor
		ringer <= 0;
		motor <= 1;
	end
	else begin
		// Normal mode, turn on ringer
		ringer <= 1;
		motor <= 0;
	end
end

endmodule

