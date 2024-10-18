
module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

reg [63:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum_final;
reg carry1, carry2, carry3, carry4, carry5, carry6, carry7;
reg stage1_en, stage2_en, stage3_en, stage4_en, stage5_en, stage6_en, stage7_en;

// Pipeline stage 1
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum1 <= 'b0;
        carry1 <= 1'b0;
        stage1_en <= 1'b0;
    end else begin
        if (i_en) begin
            stage1_en <= 1'b1;
            sum1 <= adda + addb;
            carry1 <= (adda[63] & addb[63]) | (adda[63] & carry1) | (addb[63] & carry1);
        end
    end
end

// Pipeline stage 2
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum2 <= 'b0;
        carry2 <= 1'b0;
        stage2_en <= 1'b0;
    end else begin
        if (stage1_en) begin
            stage2_en <= 1'b1;
            sum2 <= sum1;
            carry2 <= carry1;
        end
    end
end

// Pipeline stage 3
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum3 <= 'b0;
        carry3 <= 1'b0;
        stage3_en <= 1'b0;
    end else begin
        if (stage2_en) begin
            stage3_en <= 1'b1;
            sum3 <= sum2;
            carry3 <= carry2;
        end
    end
end

// Pipeline stage 4
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum4 <= 'b0;
        carry4 <= 1'b0;
        stage4_en <= 1'b0;
    end else begin
        if (stage3_en) begin
            stage4_en <= 1'b1;
            sum4 <= sum3;
            carry4 <= carry3;
        end
    end
end

// Pipeline stage 5
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum5 <= 'b0;
        carry5 <= 1'b0;
        stage5_en <= 1'b0;
    end else begin
        if (stage4_en) begin
            stage5_en <= 1'b1;
            sum5 <= sum4;
            carry5 <= carry4;
        end
    end
end

// Pipeline stage 6
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum6 <= 'b0;
        carry6 <= 1'b0;
        stage6_en <= 1'b0;
    end else begin
        if (stage5_en) begin
            stage6_en <= 1'b1;
            sum6 <= sum5;
            carry6 <= carry5;
        end
    end
end

// Pipeline stage 7
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum7 <= 'b0;
        carry7 <= 1'b0;
        stage7_en <= 1'b0;
    end else begin
        if (stage6_en) begin
            stage7_en <= 1'b1;
            sum7 <= sum6;
            carry7 <= carry6;
        end
    end
end

// Final stage - result calculation and output enable signal update
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        sum_final <= 'b0;
        result <= 'b0;
        o_en <= 1'b0;
    end else begin
        if (stage7_en) begin
            sum_final <= sum7 + {1'b0, carry7};
            result <= sum_final;
            o_en <= 1'b1;
        end
    end
end

endmodule