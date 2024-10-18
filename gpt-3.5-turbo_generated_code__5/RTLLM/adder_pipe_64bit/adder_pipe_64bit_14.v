
module adder_pipe_64bit (
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] a_reg1, b_reg1, a_reg2, b_reg2, a_reg3, b_reg3;
reg [65:0] sum_reg1, sum_reg2, sum_reg3;
reg creg1, creg2, creg3;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a_reg1 <= 64'd0;
        b_reg1 <= 64'd0;
        a_reg2 <= 64'd0;
        b_reg2 <= 64'd0;
        a_reg3 <= 64'd0;
        b_reg3 <= 64'd0;
        sum_reg1 <= 66'd0;
        sum_reg2 <= 66'd0;
        sum_reg3 <= 66'd0;
        creg1 <= 1'b0;
        creg2 <= 1'b0;
        creg3 <= 1'b0;
        o_en <= 1'b0;
        result <= 67'd0;
    end
    else if (i_en) begin
        a_reg1 <= adda;
        b_reg1 <= addb;
        creg1 <= 1'b0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a_reg2 <= 64'd0;
        b_reg2 <= 64'd0;
        sum_reg1 <= 66'd0;
    end
    else if (i_en) begin
        a_reg2 <= a_reg1;
        b_reg2 <= b_reg1;
        sum_reg1 <= {1'b0, a_reg1} + {1'b0, b_reg1};
        creg2 <= creg1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a_reg3 <= 64'd0;
        b_reg3 <= 64'd0;
        sum_reg2 <= 66'd0;
    end
    else if (i_en) begin
        a_reg3 <= a_reg2;
        b_reg3 <= b_reg2;
        sum_reg2 <= {1'b0, sum_reg1[63:0]} + {1'b0, sum_reg1[63:0]};
        creg3 <= creg2;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sum_reg3 <= 66'd0;
    end
    else if (i_en) begin
        sum_reg3 <= {creg3, sum_reg2[63:0]} + {1'b0, sum_reg2[63:0]};
        o_en <= 1'b1;
        result <= sum_reg3;
    end
end

endmodule