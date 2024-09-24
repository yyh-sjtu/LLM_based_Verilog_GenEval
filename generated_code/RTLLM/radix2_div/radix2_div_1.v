
module radix2_div (
    input wire clk,
    input wire rst,
    input wire sign,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    input wire opn_valid,
    output wire res_valid,
    output reg [15:0] result
);

reg [15:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cnt <= 4'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else begin
        if (opn_valid && res_valid == 1'b0) begin
            SR <= {1'b0, dividend};
            NEG_DIVISOR <= (sign) ? -divisor : divisor;
            start_cnt <= 1'b1;
        end
        
        if (start_cnt) begin
            if (cnt == 4'b1000) begin
                cnt <= 4'b0;
                start_cnt <= 1'b0;
                
                if (sign) begin
                    result <= (SR[7]) ? {SR[15], SR[14:8] - 8'b1} : {SR[7], SR[14:8]};
                end else begin
                    result <= {SR[7], SR[14:8]};
                end
                
                res_valid <= 1'b1;
            end else begin
                cnt <= cnt + 1;
                
                if (SR[15:8] >= NEG_DIVISOR) begin
                    SR <= {SR[14:0], 1'b0} - {NEG_DIVISOR, 1'b0};
                end else begin
                    SR <= {SR[14:0], 1'b1};
                end
            end
        end
    end
end

endmodule