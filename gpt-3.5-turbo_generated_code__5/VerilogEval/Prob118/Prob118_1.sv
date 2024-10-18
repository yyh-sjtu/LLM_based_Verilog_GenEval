
module TopModule (
    input  wire      clk,
    input  wire      areset,
    input  wire      predict_valid,
    input  wire      predict_taken,
    input  wire      train_mispredicted,
    input  wire      train_taken,
    input  wire [31:0] train_history,
    output wire [31:0] predict_history
);
    reg [31:0] branch_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history <= 0;
        end else begin
            if (train_mispredicted) begin
                branch_history <= {train_history, train_taken};
            end else if (predict_valid) begin
                branch_history <= {branch_history[30:0], predict_taken};
            end
        end
    end

    assign predict_history = branch_history;

endmodule