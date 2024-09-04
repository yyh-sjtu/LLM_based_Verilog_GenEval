
module TopModule (
    input wire mode,        // 0 for cooling mode, 1 for heating mode
    input wire too_cold,   // 1 if it's too cold
    input wire too_hot,    // 1 if it's too hot
    input wire fan_on,     // 1 if user wants the fan on
    output reg heater,     // 1 to turn on the heater
    output reg aircon,     // 1 to turn on the air conditioner
    output reg fan         // 1 to turn on the fan
);

    always @(*) begin
        // Default outputs
        heater = 0;
        aircon = 0;
        fan = 0;

        // Manage fan request
        if (fan_on) begin
            fan = 1; // Turn on fan if requested by user
        end else if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1; // Turn on heater if it's too cold
                fan = 1;    // Turn on fan to circulate air
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1; // Turn on air conditioner if it's too hot
                fan = 1;    // Turn on fan to circulate air
            end
        end
    end

endmodule