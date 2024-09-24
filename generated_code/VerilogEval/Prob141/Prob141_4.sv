
module TopModule(
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
        pm <= 1'b0;
        hours_tens <= 4'd1; // 12
        hours_ones <= 4'd2; // 12
        minutes_tens <= 6'd0; // 00
        minutes_ones <= 4'd0; // 00
        seconds_tens <= 6'd0; // 00
        seconds_ones <= 4'd0; // 00
    end else begin
        if (ena) begin
            if (seconds_ones == 4'd9) begin
                seconds_ones <= 4'd0;
                if (seconds_tens == 6'd5) begin
                    seconds_tens <= 6'd0;
                    if (minutes_ones == 4'd9) begin
                        minutes_ones <= 4'd0;
                        if (minutes_tens == 6'd5) begin
                            minutes_tens <= 6'd0;
                            if (hours_ones == 4'd9) begin
                                hours_ones <= 4'd0;
                                if (hours_tens == 4'd1) begin
                                    if (pm) begin
                                        pm <= 1'b0;
                                    end else begin
                                        pm <= 1'b1;
                                    end
                                    hours_tens <= 4'd0;
                                end else begin
                                    hours_tens <= hours_tens + 4'd1;
                                end
                            end else begin
                                if (hours_ones == 4'd2 && hours_tens == 4'd1) begin
                                    hours_tens <= 4'd0;
                                    hours_ones <= 4'd1; // reset to 12 AM
                                    pm <= 1'b0;
                                end else begin
                                    hours_ones <= hours_ones + 4'd1;
                                end
                            end
                        end else begin
                            minutes_tens <= minutes_tens + 6'd1;
                        end
                    end else begin
                        minutes_ones <= minutes_ones + 4'd1;
                    end
                end else begin
                    seconds_tens <= seconds_tens + 6'd1;
                end
            end else begin
                seconds_ones <= seconds_ones + 4'd1;
            end
        end
    end
end

assign hh = {hours_tens, hours_ones};
assign mm = {minutes_tens, minutes_ones};
assign ss = {seconds_tens, seconds_ones};

endmodule