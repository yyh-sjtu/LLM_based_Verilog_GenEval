
module TopModule(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @* begin
    // Heating mode
    if(mode == 1) begin
        if(too_cold)
            heater = 1;
        else
            heater = 0;
        
        if(heater)
            fan = 1;
        else if(fan_on)
            fan = 1;
        else
            fan = 0;
        
        aircon = 0;
    end
    // Cooling mode
    else begin
        if(too_hot)
            aircon = 1;
        else
            aircon = 0;
        
        if(aircon)
            fan = 1;
        else if(fan_on)
            fan = 1;
        else
            fan = 0;
        
        heater = 0;
    end
end

endmodule