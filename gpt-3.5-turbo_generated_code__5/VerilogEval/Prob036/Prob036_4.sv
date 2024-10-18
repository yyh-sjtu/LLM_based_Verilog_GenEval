
module TopModule(
  input ring,
  input vibrate_mode,
  output wire ringer,
  output wire motor
);

  assign ringer = (vibrate_mode == 1'b1) ? 1'b0 : ring;
  assign motor = (vibrate_mode == 1'b1) ? ring : 1'b0;

endmodule