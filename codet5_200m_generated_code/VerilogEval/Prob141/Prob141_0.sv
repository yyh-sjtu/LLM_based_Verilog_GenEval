module TopModule (
	input clk,
	input reset,
	input ena,
	output pm,
	output [7:0] hh,
	output [7:0] mm,
	output [7:0] ss
);
    reg [12:0] hours;
    reg [12:0] minutes;
    reg [12:0] seconds;
    reg clk_fast;
    always @(posedge clk_fast or posedge reset)
        if (reset) begin
            hours <= 12'b0000000000000000;
            minutes <= 12'b0000000000000000;
            seconds <= 12'b0000000000000000;
        end
        else begin
            if (ena) begin
                hours <= hours + 12'b1;
                minutes <= minutes + 12'b1;
            end
            if (clk_fast) begin
                clk_fast <= 1'b0;
            end
        end
    assign pm = hours[12];
    assign hh = hours[12:0];
    assign mm = hours[12:0];
    assign ss = hours[12:0];
endmodule

