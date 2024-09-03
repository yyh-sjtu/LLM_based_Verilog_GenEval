
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

reg [7:0] ABS_DIVIDEND;
reg [7:0] NEG_DIVISOR;
reg [8:0] cnt;
reg [7:0] SR;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ABS_DIVIDEND <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 9'b0;
        SR <= 8'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            ABS_DIVIDEND <= sign ? dividend : dividend;
            NEG_DIVISOR <= -divisor;
            cnt <= 9'b0;
            SR <= {ABS_DIVIDEND[6:0], 1'b0};
            start_cnt <= 1'b1;
        end
        
        if (start_cnt) begin
            if (cnt == 8'b11111111) begin
                cnt <= 9'b0;
                start_cnt <= 1'b0;
                res_valid <= 1'b1;
                result <= {SR[7], SR[6:0], SR[8]};
            end else begin
                cnt <= cnt + 1;
                if (SR[8] == 1'b1) begin
                    SR <= {SR[6:0] - NEG_DIVISOR, SR[8]};
                end else begin
                    SR <= {SR[6:0], SR[8]};
                end
            end
        end
    end
end

endmodule