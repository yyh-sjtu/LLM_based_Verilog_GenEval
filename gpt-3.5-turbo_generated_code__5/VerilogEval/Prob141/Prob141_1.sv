
module TopModule (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [4:0] seconds;
reg [5:0] minutes;
reg [4:0] hours;
reg pm_temp;

always @(posedge clk) begin
    if (reset) begin
        seconds <= 0;
        minutes <= 0;
        hours <= 1; // Start at 12:00 AM
        pm <= 0;
    end else if (ena) begin
        seconds <= seconds + 1;
        if (seconds == 60) begin
            seconds <= 0;
            minutes <= minutes + 1;
            if (minutes == 60) begin
                minutes <= 0;
                hours <= hours + 1;
                if (hours == 13) begin
                    hours <= 1;
                    pm_temp <= ~pm_temp;
                    pm <= pm_temp;
                end
            end
        end
    end
end

assign hh = {hours[4], hours[3], hours[2], hours[1], hours[0]};
assign mm = {minutes[5], minutes[4], minutes[3], minutes[2], minutes[1], minutes[0]};
assign ss = {seconds[4], seconds[3], seconds[2], seconds[1], seconds[0]};

endmodule