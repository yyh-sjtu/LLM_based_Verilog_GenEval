
module TopModule(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  assign heater = (mode == 1) && too_cold; // Turn on heater in heating mode when too cold
  assign aircon = (mode == 0) && too_hot;  // Turn on air conditioner in cooling mode when too hot
  assign fan = fan_on || heater || aircon; // Turn on fan when requested or when heater/aircon are on

endmodule