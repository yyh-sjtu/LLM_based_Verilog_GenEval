module multi_pipe_4bit (
    input wire clk,
    input wire rst_n,
    input wire [3:0] mul_a,
    input wire [3:0] mul_b,
    output wire [7:0] mul_out
);

parameter size = 4;

reg [7:0] partial_prod [0:size-1];
reg [7:0] sum_reg1, sum_reg2;

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_reg1 <= 8'd0;
        sum_reg2 <= 8'd0;
    end else begin
        sum_reg1 <= partial_prod[0] + partial_prod[1];
        sum_reg2 <= partial_prod[2] + partial_prod[3];
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mul_out <= 8'd0;
    end else begin
        mul_out <= sum_reg1 + (sum_reg2 << 4);
    end
end

generate
    genvar i;
    for (i = 0; i < size; i = i + 1) begin : GEN_PARTIAL_PROD
        always @ (mul_a or mul_b) begin
            if (mul_b[i]) begin
                partial_prod[i] <= {mul_a, (i+4){1'b0}};
            end else begin
                partial_prod[i] <= 8'd0;
            end
        end
    end
endgenerate

endmodule

