
module TopModule (
  input  mode,
  input  too_cold,
  input  too_hot,
  input  fan_on,
  output heater,
  output aircon,
  output fan
);

  // Internal signal declaration
  reg fan_on_internal;

  // Combinational logic for controlling heater, aircon, and fan
  always @* begin
    if (mode) begin
      // Heating mode
      heater = (too_cold && !fan_on);
      aircon = 0;
      fan = (heater || fan_on);
    end else begin
      // Cooling mode
      heater = 0;
      aircon = (too_hot && !fan_on);
      fan = (aircon || fan_on);
    end

    fan_on_internal = fan_on || heater || aircon;
  end

  // Output assignment for the fan
  always @(posedge fan_on_internal or negedge fan) begin
    fan = fan_on_internal;
  end

endmodule