
module TopModule(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [3:0] hours_tens, hours_ones;
reg [3:0] minutes_tens, minutes_ones;
reg [3:0] seconds_tens, seconds_ones;

always @(posedge clk) begin
    if (reset) begin
        pm <= 1'b0; // AM
        hours_tens <= 4'b1; // 1
        hours_ones <= 4'b2; // 2
        minutes_tens <= 4'b0; // 0
        minutes_ones <= 4'b0; // 0
        seconds_tens <= 4'b0; // 0
        seconds_ones <= 4'b0; // 0
    end else if (ena) begin
        // Increment seconds
        if (seconds_ones == 4'b9) begin
            seconds_ones <= 4'b0;
            if (seconds_tens == 4'b5) begin
                seconds_tens <= 4'b0;
                // Increment minutes
                if (minutes_ones == 4'b9) begin
                    minutes_ones <= 4'b0;
                    if (minutes_tens == 4'b5) begin
                        minutes_tens <= 4'b0;
                        // Increment hours (12-hour)
                        if (hours_ones == 4'b9 && hours_tens == 4'b1) begin
                            hours_tens <= 4'b0;
                            hours_ones <= 4'b0;
                            // Toggle AM/PM
                            pm <= ~pm;
                        end else if (hours_ones == 4'b9) begin
                            hours_ones <= 4'b0;
                            hours_tens <= hours_tens + 1;
                        end else begin
                            hours_ones <= hours_ones + 1;
                        end
                    end else if (minutes_tens == 4'b5) begin
                        minutes_tens <= 4'b0;
                        minutes_ones <= minutes_ones + 1;
                    end else begin
                        minutes_ones <= minutes_ones + 1;
                    end
                end else if (minutes_ones == 4'b9) begin
                    minutes_ones <= 4'b0;
                    minutes_tens <= minutes_tens + 1;
                end else begin
                    minutes_ones <= minutes_ones + 1;
                end
            end else if (seconds_tens == 4'b5) begin
                seconds_tens <= 4'b0;
                seconds_ones <= seconds_ones + 1;
            end else begin
                seconds_ones <= seconds_ones + 1;
            end
        end else begin
            seconds_ones <= seconds_ones + 1;
        end
    end
end

assign hh = {hours_tens, hours_ones};
assign mm = {minutes_tens, minutes_ones};
assign ss = {seconds_tens, seconds_ones};

endmodule