
module TopModule(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater;
reg aircon;
reg fan;

always @(*) begin
    if(mode && too_cold) begin
        // Heating mode - turn on heater and fan
        heater = 1;
        aircon = 0;
        fan = 1;
    end else if(!mode && too_hot) begin
        // Cooling mode - turn on air conditioner and fan
        heater = 0;
        aircon = 1;
        fan = 1;
    end else if(fan_on) begin
        // User requested fan on
        heater = 0;
        aircon = 0;
        fan = 1;
    end else begin
        // Turn everything off
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

assign heater = heater;
assign aircon = aircon;
assign fan = fan;

endmodule