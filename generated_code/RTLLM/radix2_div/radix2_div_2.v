
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

reg [7:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SR <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
        result <= 16'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            SR <= {1'b0, dividend};
            NEG_DIVISOR <= (sign ? -divisor : divisor);
            cnt <= 4'b1;
            start_cnt <= 1'b1;
        end
        
        if (start_cnt) begin
            if (cnt == 4'b1000) begin
                cnt <= 4'b0;
                start_cnt <= 1'b0;
                result[15:8] <= SR[7:0];
                result[7:0] <= SR[15:8];
                res_valid <= 1'b1;    
            end else begin
                cnt <= cnt + 1;
                SR <= (SR[7] == 1'b1) ? (SR << 1) + NEG_DIVISOR : (SR << 1);
            end
        end
    end
end

endmodule