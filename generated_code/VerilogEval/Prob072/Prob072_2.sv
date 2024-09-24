
module TopModule (
    input wire mode,        // 1 for heating, 0 for cooling
    input wire too_cold,    // 1 if too cold
    input wire too_hot,     // 1 if too hot
    input wire fan_on,      // 1 if fan should be turned on
    output reg heater,      // 1 to turn on heater
    output reg aircon,      // 1 to turn on aircon
    output reg fan          // 1 to turn on fan
);

    always @(*) begin
        // Default outputs
        heater = 0;
        aircon = 0;
        fan = 0;

        if (fan_on) begin
            fan = 1; // Turn on fan if requested
        end
        else begin
            // Check mode to control heater and aircon
            if (mode) begin
                // Heating mode
                if (too_cold) begin
                    heater = 1; // Turn on heater if too cold
                    fan = 1;    // Turn on fan for circulation
                end
            end else begin
                // Cooling mode
                if (too_hot) begin
                    aircon = 1; // Turn on aircon if too hot
                    fan = 1;    // Turn on fan for circulation
                end
            end
        end
    end
endmodule