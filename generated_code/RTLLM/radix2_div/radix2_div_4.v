
module radix2_div (
    input wire clk,
    input wire rst,
    input wire sign,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    input wire opn_valid,
    output reg res_valid,
    output reg [15:0] result
);

// Internal signals
reg [15:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg [1:0] start_cnt;

// Operation start
always @(posedge clk or posedge rst) begin
    if (rst) begin
        res_valid <= 0;
        SR <= 16'b0;
        cnt <= 4'b0;
        start_cnt <= 2'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            SR <= {1'b0, dividend} << 1;
            NEG_DIVISOR <= -divisor;
            start_cnt <= 2'b01;
        end
    end
end

// Division process
always @(posedge clk) begin
    if (start_cnt[1] && !res_valid) begin
        if (cnt == 4'b1000) begin
            cnt <= 4'b0;
            start_cnt <= 2'b0;
            result <= {SR[15], SR[7:0]};
            res_valid <= 1;
        end else begin
            cnt <= cnt + 1;
            if (sign) begin
                if (SR[15]) begin
                    SR <= {SR[15], SR[14:1]} + NEG_DIVISOR;
                end else begin
                    SR <= {SR[15], SR[14:1]};
                end
            end else begin
                SR <= {SR[15], SR[14:1]} + NEG_DIVISOR;
            end
        end
    end
end

endmodule