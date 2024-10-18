
module TopModule(
  input  wire clk,
  input  wire areset,
  
  input  wire predict_valid,
  input  wire [6:0] predict_pc,
  output wire predict_taken,
  output wire [6:0] predict_history,
  
  input  wire train_valid,
  input  wire train_taken,
  input  wire train_mispredicted,
  input  wire [6:0] train_history,
  input  wire [6:0] train_pc
);

  reg [6:0] history_register;
  reg [6:0] predict_index;
  reg [127:0] pattern_history_table;
  wire [1:0] predict_state;
  reg [6:0] train_index;
  reg [1:0] train_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset branch predictor state
      history_register <= 7'b0;
      pattern_history_table <= 128'b0;
    end else if (predict_valid) begin
      // Prediction request
      predict_index <= predict_pc ^ history_register;
      predict_state <= pattern_history_table[predict_index];
      predict_taken <= (predict_state[1] == 2'b11) ? 1'b1 : 1'b0;
      predict_history <= history_register;
    end else if (train_valid) begin
      // Training request
      train_index <= train_pc ^ train_history;
      train_state <= pattern_history_table[train_index];
      
      if (train_mispredicted) begin
        // Training for misprediction
        pattern_history_table[train_index] <= (train_state == 2'b00) ? 2'b01 : 2'b00;
        history_register <= train_history;
      end else begin
        // Training for correct prediction
        pattern_history_table[train_index] <= (train_state == 2'b11) ? 2'b11 : 2'b10;
      end
    end
  end
  
endmodule