
module TopModule (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [3:0] hours_tens, hours_ones, minutes_tens, minutes_ones, seconds_tens, seconds_ones;

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        pm <= 0;
        hours_tens <= 1;
        hours_ones <= 2;
        minutes_tens <= 0;
        minutes_ones <= 0;
        seconds_tens <= 0;
        seconds_ones <= 0;
    end else begin
        if (ena) begin
            // Increment the clock every second
            seconds_ones <= seconds_ones + 1;
            if (seconds_ones == 10) begin
                seconds_ones <= 0;
                seconds_tens <= seconds_tens + 1;
                if (seconds_tens == 6) begin
                    seconds_tens <= 0;
                    minutes_ones <= minutes_ones + 1;
                    if (minutes_ones == 10) begin
                        minutes_ones <= 0;
                        minutes_tens <= minutes_tens + 1;
                        if (minutes_tens == 6) begin
                            minutes_tens <= 0;
                            hours_ones <= hours_ones + 1;
                            if (hours_ones == 10) begin
                                hours_ones <= 0;
                                hours_tens <= hours_tens + 1;
                                if (hours_tens == 1 && hours_ones == 3) begin
                                    // Reset the hour to 1 if it reaches 13
                                    hours_tens <= 1;
                                    hours_ones <= 1;
                                    // Toggle the AM/PM indicator
                                    pm <= ~pm;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

assign hh = {hours_tens, hours_ones};
assign mm = {minutes_tens, minutes_ones};
assign ss = {seconds_tens, seconds_ones};

endmodule