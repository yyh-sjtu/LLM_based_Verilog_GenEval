module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Declare internal signal to control ringer and motor
reg ringer_control;
reg motor_control;

always @ (ring or vibrate_mode)
begin
	if (vibrate_mode == 1)
	begin
		ringer_control <= 0;
		motor_control <= 1;
	end
	else
	begin
		ringer_control <= 1;
		motor_control <= 0;
	end
end

assign ringer = ringer_control;
assign motor = motor_control;

endmodule

