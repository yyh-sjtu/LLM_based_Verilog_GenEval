module TopModule (
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [7:0] branch_pc;
    assign predict_taken = branch_pc[0];
    assign predict_history = branch_pc[7:0];
    always @(posedge clk or posedge areset) begin
        if (areset == 1'b1) begin
            branch_pc <= 7'b0;
            branch_pc[0] <= 7'b0;
            branch_pc[1] <= 7'b0;
            branch_pc[2] <= 7'b0;
            branch_pc[3] <= 7'b0;
            branch_pc[4] <= 7'b0;
            branch_pc[5] <= 7'b0;
            branch_pc[6] <= 7'b0;
            branch_pc[7] <= 7'b0;
        end else begin
            branch_pc <= branch_pc ^ branch_pc[1];
            branch_pc[2] <= branch_pc[0];
            branch_pc[3] <= branch_pc[1];
            branch_pc[4] <= branch_pc[2];
            branch_pc[5] <= branch_pc[3];
            branch_pc[6] <= branch_pc[4];
            branch_pc[7] <= branch_pc[5];
            branch_pc[8] <= branch_pc[6];
            branch_pc[9] <= branch_pc[3];
            branch_pc[10] <= branch_pc[4];
            branch_pc[11] <= branch_pc[5];
            branch_pc[12] <= branch_pc[6];
            branch_pc[13] <= branch_pc[6];
            branch_pc[14] <= branch_pc[5];
            branch_pc[15] <= branch_pc[6];
            branch_pc[16] <= branch_pc[5];
            branch_pc[17] <= branch_pc[6];
            branch_pc[18] <= branch_pc[5];
            branch_pc[19] <= branch_pc[6];
            branch_pc[20] <= branch_pc[5];
            branch_pc[21] <= branch_pc[6];
            branch_pc[22] <= branch_pc[6];
            branch_pc[23] <= branch_pc[5];
            branch_pc[24] <= branch_pc[6];
            branch_pc[25] <= branch_pc[6];
            branch_pc[26] <= branch_pc[5];
            branch_pc[27] <= branch_pc[5];
            branch_pc[28] <= branch_pc[6];
            branch_pc[29] <= branch_pc[5];
            branch_pc[30] <= branch_pc[5];
            branch_pc[31] <= branch_pc[6];
            branch_pc[32] <= branch_pc[6];
            branch_pc[33] <= branch_pc[6];
            branch_pc[34] <= branch_pc[5];
            branch_pc[35] <= branch_pc[6];
            branch_pc[36] <= branch_pc[6];
            branch_pc[37] <= branch_pc[6];
            branch_pc[38] <= branch_pc[5];
            branch_pc[39] <= branch_pc[6];
            branch_pc[40] <= branch_pc[6];
            branch_pc[41] <= branch_pc[5];
            branch_pc[42] <= branch_pc[6];
            branch_pc[43] <= branch_pc[5];
            branch_pc[43:0] <= branch_pc[6:0];
        end
    end
endmodule

