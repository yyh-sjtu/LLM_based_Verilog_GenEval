
module TopModule(
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

  // Define internal registers and wires
  reg [6:0] branch_history;
  wire [6:0] index;
  reg [1:0] pht [0:127];
  
  // Combinational logic for index calculation
  assign index = predict_history ^ predict_pc;
  
  // Output the predicted branch direction and branch history
  // based on the index and PHT state
  always @(posedge clk) begin
    if (areset) begin
      predict_taken <= 0;
      predict_history <= 0;
    end else if (predict_valid) begin
      predict_taken <= pht[index] >= 2 ? 1 : 0;
      predict_history <= branch_history;
    end
  end
  
  // Train the branch predictor based on the training input
  always @(posedge clk) begin
    if (areset) begin
      branch_history <= 0;
    end else if (train_valid) begin
      if (train_mispredicted) begin
        branch_history <= train_history;
      end
      pht[index] <= train_taken ? pht[index] == 3 ? 3 : pht[index] + 1 :
                                   pht[index] == 0 ? 0 : pht[index] - 1;
    end
  end

endmodule