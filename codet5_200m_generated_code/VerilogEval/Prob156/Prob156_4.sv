module TopModule (
	input clk,
	input reset,
	input data,
	output [3:0] count,
	output counting,
	output done,
	input ack
);
    reg [3:0] timer;
    reg [3:0] count_reg;
    reg done_reg;
    always @(posedge clk) begin
        if (reset) begin
            timer <= 0;
            count_reg <= 0;
            done_reg <= 0;
        end else begin
            if (ack) begin
                if (timer == 1101) begin
                    timer <= 0;
                    count_reg <= 0;
                end else begin
                    if (timer == 1101) begin
                            count_reg <= count_reg + 1;
                            done_reg <= 1;
                    end
                end
            end
        end
    end
    assign count = count_reg;
    assign done = done_reg;
    assign counting = count_reg;
endmodule

