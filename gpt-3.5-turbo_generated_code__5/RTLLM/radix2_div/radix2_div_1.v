
module radix2_div (
    input wire clk,
    input wire rst,
    input wire sign,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    input wire opn_valid,
    output wire res_valid,
    output wire [15:0] result
);

reg [15:0] result_reg;
reg [7:0] SR, NEG_DIVISOR;
reg [3:0] cnt, start_cnt;
wire [9:0] subtraction_result;
wire carry_out;

always@(posedge clk or posedge rst) begin
    if(rst) begin
        SR <= 0;
        NEG_DIVISOR <= 0;
        cnt <= 0;
        start_cnt <= 0;
        result_reg <= 0;
        res_valid <= 0;
    end else if(opn_valid && !res_valid) begin
        SR <= {1'b0, abs(dividend)};
        NEG_DIVISOR <= -abs(divisor);
        cnt <= 4'b0001;
        start_cnt <= 4'b0001;
    end else if(start_cnt) begin
        if(cnt == 4'b1000) begin
            cnt <= 4'b0000;
            start_cnt <= 4'b0000;
            result_reg[15:8] <= SR[7:0];
            result_reg[7:0] <= SR[15:8];
            res_valid <= 1;
        end else begin
            cnt <= cnt + 1;
            subtraction_result <= SR[7:0] + NEG_DIVISOR;
            carry_out <= subtraction_result[8];
            SR <= {SR[6:0], carry_out};
        end
    end
end

assign result = result_reg;

endmodule