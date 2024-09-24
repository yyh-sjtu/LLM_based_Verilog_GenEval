module TopModule (
	input clk,
	input reset,
	input ena,
	output pm,
	output [7:0] hh,
	output [7:0] mm,
	output [7:0] ss
);
    reg [11:0] hh_c, hh_d, hh_d;
    reg [8:0] mm_c, mm_d;
    reg [7:0] ss_c;
    initial begin
        hh_c = 0;
        hh_d = 0;
        mm_c = 0;
        ss_c = 0;
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh_c <= 0;
            hh_d <= 0;
            mm_c <= 0;
            ss_c <= 0;
        end
        else begin
            if (ena) begin
                if (hh_c == 12'h1f) begin
                    hh_c <= hh_d;
                    hh_d <= hh_d + 12'h1f;
                end else begin
                    hh_c <= hh_d;
                    hh_d <= hh_d + 12'h1f;
                end
            end
        end
    end
    assign pm = hh_c[14];
    assign hh = hh_c[7:5];
    assign mm = hh_c[6:5];
    assign ss = hh_c[7:6];
endmodule

