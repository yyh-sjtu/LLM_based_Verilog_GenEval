module TopModule (
	input clk,
	input reset,
	output [9:0] q
);
    parameter REG_WIDTH = 9;
    reg [REG_WIDTH-1:0] cnt;
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            cnt <= 0;
        else
            if(cnt == REG_WIDTH-1)
                cnt <= 0;
        else
            if(cnt == 0)
                cnt <= 1;
    end
    assign q = cnt;
endmodule

