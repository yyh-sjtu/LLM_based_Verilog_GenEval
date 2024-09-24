module calendar (
	input CLK,
	input RST,
	output [5:0] Hours,
	output [5:0] Mins,
	output [5:0] Secs
);
    reg [5:0] seconds;
    reg [5:0] minutes;
    reg [5:0] hours;
    reg [5:0] sec;
    reg [5:0] code;
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            seconds <= 0;
            minutes <= 0;
            hours <= 0;
            code <= 0;
        end else begin
            seconds <= seconds + 1;
            minutes <= minutes + 1;
            hours <= hours + 1;
            code <= code + 1;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            seconds <= 0;
            minutes <= 0;
            hours <= 0;
            sec <= 0;
        end else begin
            seconds <= seconds + 1;
            minutes <= minutes + 1;
            hours <= hours + 1;
            sec <= sec + 1;
        end
    end
endmodule

