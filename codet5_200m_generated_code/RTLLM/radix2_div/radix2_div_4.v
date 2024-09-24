module radix2_div (
	input clk,
	input rst,
	input sign,
	input [7:0] dividend,
	input [7:0] divisor,
	input opn_valid,
	output reg res_valid,
	output reg [15:0] result
);
    reg [15:0] quotient;
    reg [15:0] remainder;
    always @(posedge clk) begin
        if (rst) begin
            res_valid <= 0;
            result <= 0;
        end else begin
            if (opn_valid) begin
                if (sign) begin
                    if (dividend < divisor) begin
                            res_valid <= 1;
                            result <= quotient;
                end
                else begin
                            res_valid <= 0;
                            result <= remainder;
                end
            end
            end
        end
    end
endmodule

