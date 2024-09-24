
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

reg [1:0] pht [0:127];
reg [6:0] global_history = 7'b0;

always @(posedge clk) begin
    if (areset) begin
        // Reset the branch predictor
        global_history <= 7'b0;
        for (int i=0; i<128; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        // Predict branch direction
        if (predict_valid) begin
            predict_taken <= pht[global_history ^ predict_pc][1];
            predict_history <= pht[global_history ^ predict_pc];
        end
        // Train branch predictor
        if (train_valid) begin
            if (train_mispredicted) begin
                global_history <= train_history; // Recover from misprediction
            end
            pht[global_history ^ train_pc][1] <= train_taken ? 
                (pht[global_history ^ train_pc][1] < 3'b11 ? 
                pht[global_history ^ train_pc][1] + 1 : 3'b11) : 
                (pht[global_history ^ train_pc][1] > 3'b00 ? 
                pht[global_history ^ train_pc][1] - 1 : 3'b00);
            global_history <= {global_history[5:0], train_taken};
        end
    end
end

endmodule