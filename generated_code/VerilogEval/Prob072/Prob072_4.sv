
module TopModule (
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater, aircon, fan;

always @(*) begin
    if (mode) begin // heating mode
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end else begin
            heater = 0;
        end
        aircon = 0;
    end else begin // cooling mode
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end else begin
            aircon = 0;
        end
        heater = 0;
    end
    
    if (fan_on) begin
        fan = 1;
    end else begin
        if (!heater && !aircon) begin
            fan = 0;
        end
    end
end

assign heater = heater;
assign aircon = aircon;
assign fan = fan;

endmodule