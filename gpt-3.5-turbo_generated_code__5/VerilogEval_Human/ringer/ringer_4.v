module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Define a logic signal to control whether to turn on the ringer or motor
reg control_signal;

// Assign control_signal based on the input conditions
always @ (ring, vibrate_mode)
begin
	if (vibrate_mode == 1) // Phone is in vibrate mode
		control_signal = 1'b0; // Turn on the motor
	else // Phone is not in vibrate mode
		control_signal = 1'b1; // Turn on the ringer
end

// Assign outputs based on the control_signal
assign ringer = control_signal;
assign motor = ~control_signal;

endmodule

