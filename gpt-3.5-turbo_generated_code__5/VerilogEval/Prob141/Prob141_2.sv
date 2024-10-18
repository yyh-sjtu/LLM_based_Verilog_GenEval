
module TopModule (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [3:0] hours_tens;
reg [3:0] hours_ones;
reg [5:0] minutes_tens;
reg [3:0] minutes_ones;
reg [5:0] seconds_tens;
reg [3:0] seconds_ones;

always @(posedge clk) begin
    if (reset) begin
        hours_tens <= 4'b0001; // 1
        hours_ones <= 4'b0010; // 2
        minutes_tens <= 6'b0000; // 0
        minutes_ones <= 4'b0000; // 0
        seconds_tens <= 6'b0000; // 0
        seconds_ones <= 4'b0000; // 0
        pm <= 1'b0; // AM
    end else begin
        if (ena) begin
            seconds_ones <= (seconds_ones == 4'b1001) ? 4'b0000 : seconds_ones + 1;
            if (seconds_ones == 4'b0000) begin
                seconds_tens <= (seconds_tens == 6'b0101) ? 6'b0000 : seconds_tens + 1;
                if (seconds_tens == 6'b0000) begin
                    minutes_ones <= (minutes_ones == 4'b1001) ? 4'b0000 : minutes_ones + 1;
                    if (minutes_ones == 4'b0000) begin
                        minutes_tens <= (minutes_tens == 6'b0101) ? 6'b0000 : minutes_tens + 1;
                        if (minutes_tens == 6'b0000) begin
                            if ((hours_tens == 4'b0000 && hours_ones == 4'b1001) || (hours_tens == 4'b0001 && hours_ones == 4'b0011)) begin
                                hours_tens <= 4'b0000;
                                hours_ones <= 4'b0001;
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hours_ones <= (hours_ones == 4'b1001) ? 4'b0000 : hours_ones + 1;
                                if (hours_ones == 4'b0000) begin
                                    hours_tens <= (hours_tens == 4'b0001) ? 4'b0000 : hours_tens + 1;
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