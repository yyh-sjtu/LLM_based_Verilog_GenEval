
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

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        SR <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0000;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else if (opn_valid && !res_valid) begin
        SR <= {1'b0, dividend};
        NEG_DIVISOR <= (sign) ? -divisor : divisor;
        cnt <= 4'b0001;
        start_cnt <= 1'b1;
    end else if (start_cnt) begin
        if (cnt == 4'b1000) begin
            cnt <= 4'b0000;
            start_cnt <= 1'b0;
            result <= {SR, SR};
            res_valid <= 1'b1;
        end else begin
            cnt <= cnt + 1;
            if (SR[7]) begin
                SR <= {SR[6:0], 1'b0};
            else begin
                SR <= SR - NEG_DIVISOR;
            end
        end
    end
end

endmodule