
module TopModule (
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @ (mode, too_cold, too_hot, fan_on)
begin
    if (mode == 1) begin // Heating mode
        if (too_cold == 1) begin
            heater = 1;
            fan = 1;
            aircon = 0;
        end
        else begin
            heater = 0;
            fan = fan_on;
            aircon = 0;
        end
    end
    else begin // Cooling mode
        if (too_hot == 1) begin
            aircon = 1;
            fan = 1;
            heater = 0;
        end
        else begin
            aircon = 0;
            fan = fan_on;
            heater = 0;
        end
    end
end

endmodule