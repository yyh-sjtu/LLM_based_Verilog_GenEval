module global_history_shift_register (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

reg [31:0] shift_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        shift_reg <= 32'b0;
        predict_history <= 32'b0;
    end else if (predict_valid) begin
        shift_reg <= {shift_reg[30:0], predict_taken};
    end else if (train_mispredicted) begin
        shift_reg <= {train_history[31], shift_reg[30:1], train_taken};
    end else begin
        shift_reg <= {shift_reg[30:0], 1'b0};
    end
end

assign predict_history = shift_reg;

endmodule

