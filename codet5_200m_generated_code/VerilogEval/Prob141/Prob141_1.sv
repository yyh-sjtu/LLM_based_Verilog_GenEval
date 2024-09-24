module TopModule (
	input clk,
	input reset,
	input ena,
	output pm,
	output [7:0] hh,
	output [7:0] mm,
	output [7:0] ss
);
    reg [7:0] hr;
    reg [7:0] mm;
    reg [7:0] ss;
    always @(posedge clk) begin
        if (reset) begin
            hr <= 0;
            mm <= 0;
            ss <= 0;
        end else begin
            hr <= hr + 1;
            mm <= mm + 1;
            ss <= ss + 1;
        end
    end
endmodule

