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

always @(posedge clk) begin
    if (rst == 1'b1) begin
        res_valid <= 1'b0;
        SR <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0;
        start_cnt <= 1'b1;
    end else begin
        if (opn_valid == 1'b1 && res_valid != 1'b1) begin
            if (start_cnt == 1'b1) begin
                SR <= {dividend, 1'b0}; // Left shift dividend by 1 bit
                NEG_DIVISOR <= -divisor;
                start_cnt <= 1'b0;
            end else begin
                if (cnt == 4'b1000) begin
                    cnt <= 4'b0;
                    start_cnt <= 1'b1;
                    result <= {SR, SR[7:0]}; // Store remainder in upper 8 bits, quotient in lower 8 bits
                    res_valid <= 1'b1;
                end else begin
                    cnt <= cnt + 1;
                    if (SR[7] == 1'b1) begin
                        SR <= {SR, 1'b0} - NEG_DIVISOR;
                    end else begin
                        SR <= {SR, 1'b0};
                    end
                end
            end
        end
    end
end

endmodule

