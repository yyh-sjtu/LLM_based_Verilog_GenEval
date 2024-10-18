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

reg [15:0] SR;
reg [7:0] NEG_DIVISOR;
reg [3:0] cnt;
reg start_cnt;

always @ (posedge clk or posedge rst) begin
    if (rst) begin
        SR <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            SR <= {dividend, 1'b0}; // Shift dividend left by 1
            NEG_DIVISOR <= (sign) ? -divisor : divisor; // Negate and obtain absolute value
            cnt <= 4'b0001;
            start_cnt <= 1'b1;
        end else begin
            if (start_cnt) begin
                if (cnt == 4'b1000) begin
                    cnt <= 4'b0;
                    start_cnt <= 1'b0;
                    // Update SR with remainder in upper 8 bits and quotient in lower 8 bits
                    SR <= {SR[15:8], SR[7:0]}; 
                    res_valid <= 1'b1;
                end else begin
                    cnt <= cnt + 1;
                    // Perform subtraction of NEG_DIVISOR and update SR
                    if (SR[15] == 1'b0) begin
                        SR <= {SR[14:0], 1'b0};
                    end else begin
                        SR <= {SR[14:0], 1'b0} - {~NEG_DIVISOR, 1'b0};
                    end
                end
            end
        end
    end
end

assign result = SR;

endmodule

