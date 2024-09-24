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
    reg [6:0] branch_pc;
    reg [6:0] branch_history;
    always @(posedge clk)
        if (areset)
            branch_pc <= 7'b0;
        else if (predict_valid && (branch_pc == 7'b11111111) )
            branch_pc <= branch_pc + 1'b1;
    always @(posedge clk)
        branch_history <= branch_history | branch_pc;
    always @(posedge clk)
        branch_taken <= branch_taken | branch_pc == 7'b11111111;
endmodule

