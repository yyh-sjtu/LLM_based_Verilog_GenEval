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
reg [7:0] NEG_DIVISOR;
reg [7:0] remainder;
reg [7:0] quotient;
reg [7:0] SR;
reg [3:0] cnt;
reg start_cnt;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        res_valid <= 0;
        result <= 16'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            abs_dividend <= sign ? dividend[7] ? -dividend + 1 : dividend;
            SR <= {abs_dividend, 1'b0};
            NEG_DIVISOR <= -divisor;
            cnt <= 4'b1;
            start_cnt <= 1;
        end 
        
        if (start_cnt) begin
            if (cnt == 4'b1000) begin
                cnt <= 4'b0;
                start_cnt <= 0;
                remainder <= SR[7:0];
                quotient <= SR[15:8];
                result <= {remainder, quotient};
                res_valid <= 1;
            end else begin
                cnt <= cnt + 1;
                if (SR >= {8'b0, NEG_DIVISOR}) begin
                    SR <= {SR, 1'b0} - {8'b0, NEG_DIVISOR};
                end else begin
                    SR <= {SR, 1'b1};
                end
            end
        end
    end
end

endmodule

