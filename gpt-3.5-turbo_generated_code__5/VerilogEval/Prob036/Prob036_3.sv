
module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  assign ringer = ~vibrate_mode & ring; // Turn on the ringer if not in vibrate mode and there is an incoming call
  assign motor = vibrate_mode & ring; // Turn on the motor if in vibrate mode and there is an incoming call

endmodule