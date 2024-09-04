
module TopModule (
    input  mode,        // Thermostat mode: 1 for heating, 0 for cooling
    input  too_cold,    // Signal indicating it's too cold
    input  too_hot,     // Signal indicating it's too hot
    input  fan_on,      // User request for fan to be on
    output reg heater,   // Heater control output
    output reg aircon,   // Air conditioner control output
    output reg fan       // Fan control output
);

always @(*) begin
    // Default outputs
    heater = 0;
    aircon = 0;
    fan = 0;

    // Control logic for the thermostat
    if (fan_on) begin
        // If requested by the user, turn on the fan
        fan = 1;
    end else begin
        // Control based on mode
        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1;   // Turn on the heater
                fan = 1;      // Turn on the fan
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1;   // Turn on the air conditioner
                fan = 1;      // Turn on the fan
            end
        end
    end
end

endmodule