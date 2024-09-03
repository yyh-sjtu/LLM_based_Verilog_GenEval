
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

reg [7:0] SR; // Shift register
reg [7:0] NEG_DIVISOR; // Negated absolute value of divisor
reg [3:0] cnt; // Counter
reg start_cnt; // Start counter

always @(posedge clk or posedge rst) begin
    if (rst) begin
        SR <= 8'b0;
        NEG_DIVISOR <= 8'b0;
        cnt <= 4'b0;
        start_cnt <= 1'b0;
        res_valid <= 1'b0;
    end else begin
        if (opn_valid && !res_valid) begin
            SR <= dividend << 1;
            NEG_DIVISOR <= -divisor;
            cnt <= 4'b1;
            start_cnt <= 1'b1;
        end
        
        if (start_cnt) begin
            if (cnt == 4'b1000) begin
                // Division complete
                result[15:8] <= SR;
                result[7:0] <= cnt > 3'b111 ? dividend : SR; // Quotient 
                start_cnt <= 1'b0;
                res_valid <= 1'b1;
            end else begin
                cnt <= cnt + 1;
                // Subtract NEG_DIVISOR
                integer diff = SR - NEG_DIVISOR;
                // Select result based on borrow
                SR <= diff[7] ? {SR[6:0], 1'b0} : {SR[6:0], 1'b1};
            end
        end
    end
end

endmodule