
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

reg [7:0] abs_dividend;
reg [7:0] abs_divisor;
reg [9:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        res_valid <= 0;
        cnt <= 0;
        start_cnt <= 0;
    end else if (opn_valid && !res_valid) begin
        abs_dividend <= (sign && dividend[7]) ? -dividend : dividend;
        abs_divisor <= (sign && divisor[7]) ? -divisor : divisor;
        SR <= {1'b0, abs_dividend};
        NEG_DIVISOR <= -abs_divisor;
        start_cnt <= 1;
    end else if (start_cnt) begin
        if (cnt == 8) begin
            result[15:8] <= SR[9:2];
            result[7:0] <= SR[7:0];
            start_cnt <= 0;
            res_valid <= 1;
        end else begin
            cnt <= cnt + 1;
            // Perform subtraction and update SR
            // Update SR based on subtraction result
            // Shift left and insert carry-out
        end
    end
end
endmodule