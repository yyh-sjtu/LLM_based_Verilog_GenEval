
module radix2_div(
    input clk,
    input rst,
    input sign,
    input [7:0] dividend,
    input [7:0] divisor,
    input opn_valid,
    output reg res_valid,
    output reg [15:0] result
);

reg [15:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SR <= 16'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            SR <= {1'b0, dividend} << 1;
            NEG_DIVISOR <= sign ? -divisor : divisor;
            start_cnt <= 1'b1;
        end
        if (start_cnt) begin
            if (cnt == 4'b1000) begin
                cnt <= 4'b0;
                start_cnt <= 1'b0;
                result <= {SR[15], SR[14:8]};
                res_valid <= 1'b1;
            end else begin
                cnt <= cnt + 1;
                if(SR[15]) begin
                    SR <= {SR[14:0], 1'b0};
                end else begin
                    SR <= SR - {1'b0, NEG_DIVISOR}; // Perform subtraction
                    SR <= SR << 1;
                end
            end
        end
    end
end

endmodule