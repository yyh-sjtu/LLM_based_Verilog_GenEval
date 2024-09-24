
module TopModule (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history,
    output reg [31:0] predict_history
);

reg [31:0] branch_history_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_reg <= 32'b0;
    end else begin
        if (train_mispredicted) begin
            branch_history_reg <= {train_history, train_taken};
        end else if (predict_valid) begin
            branch_history_reg <= {branch_history_reg[30:0], predict_taken};
        end
    end
end

assign predict_history = branch_history_reg;

endmodule