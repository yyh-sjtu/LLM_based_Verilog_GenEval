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
reg [7:0] SR;
reg [7:0] NEG_DIVISOR;
reg [7:0] neg_divisor_abs;
reg [3:0] cnt;
reg [3:0] start_cnt;

always @ (posedge clk or posedge rst)
begin
    if (rst)
    begin
        res_valid <= 0;
        cnt <= 0;
        start_cnt <= 0;
        SR <= 8'b0;
        result_reg <= 16'b0;
        NEG_DIVISOR <= 8'b0;
        neg_divisor_abs <= 8'b0;
    end
    else
    begin
        if (opn_valid && !res_valid)
        begin
            neg_divisor_abs <= (sign) ? -divisor : divisor;
        end

        if (start_cnt)
        begin
            SR <= {dividend, 1'b0};
            NEG_DIVISOR <= neg_divisor_abs;
            
            if (SR >= NEG_DIVISOR)
            begin
                SR <= SR - NEG_DIVISOR;
                result_reg[7:0] <= result_reg[7:0] << 1 | 1'b1;
            end
            else
            begin
                result_reg[7:0] <= result_reg[7:0] << 1;
            end
            
            start_cnt <= 0;
            cnt <= cnt + 1;
        end
        
        if (cnt[3])
        begin
            result_reg[15:8] <= SR;
            res_valid <= 1;
            start_cnt <= 1;
            cnt <= 0;
        end
        else
        begin
            SR <= {SR[6:0], SR[7]};
            if (SR >= NEG_DIVISOR)
            begin
                SR <= SR - NEG_DIVISOR;
                result_reg[7:0] <= result_reg[7:0] << 1 | 1'b1;
            end
            else
            begin
                result_reg[7:0] <= result_reg[7:0] << 1;
            end
            cnt <= cnt + 1;
        end
    end
end

assign result = result_reg;

endmodule

