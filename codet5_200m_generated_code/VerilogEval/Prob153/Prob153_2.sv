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
    wire [7:0] pc_to_next;
    wire [7:0] pc_to_next_reg;
    assign predict_taken = (pc == pc_to_next_reg) & predict_valid;
    assign predict_history = (pc == pc_to_next_reg) & predict_valid;
    assign train_mispredicted = (pc == pc_to_next_reg) & predict_valid;
    assign train_pc = (predict_pc == pc_to_next_reg) & predict_valid;
    assign predict_pc = (predict_pc == pc_to_next_reg) & predict_valid;
    always @ (posedge clk) begin
        if (areset) begin
            pc_to_next <= 7'b0;
            predict_pc <= 7'b0;
        end
    end
    always @ (posedge clk) begin
        if (areset) begin
            predict_pc <= 7'b0;
        end
    end
endmodule

