
module TopModule (
  input  clk,
  input  areset,

  input  predict_valid,
  input  [6:0] predict_pc,
  output predict_taken,
  output [6:0] predict_history,

  input  train_valid,
  input  train_taken,
  input  train_mispredicted,
  input  [6:0] train_history,
  input  [6:0] train_pc
);

  // Constants
  parameter TABLE_SIZE = 128;
  parameter INDEX_SIZE = 7;
  parameter HISTORY_SIZE = 7;

  // Internal signals
  reg [TABLE_SIZE-1:0] pattern_history_table;
  reg [HISTORY_SIZE-1:0] global_history_register;
  reg [1:0] predict_counter;
  reg [HISTORY_SIZE-1:0] predict_history_reg;

  // Branch prediction logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      predict_taken <= 0;
      predict_counter <= 0;
      predict_history_reg <= 0;
    end else begin
      if (predict_valid) begin
        predict_taken <= (predict_counter[1] == 2 || predict_counter[1] == 3);
        predict_history_reg <= predict_history;
      end
      if (train_valid) begin
        predict_counter <= predict_counter + {(predict_counter[1] ^ train_taken), train_taken};
        pattern_history_table[{train_pc[6:INDEX_SIZE], global_history_register}] <= predict_counter;
        if (train_mispredicted)
          global_history_register <= {global_history_register[HISTORY_SIZE-2:0], 1'b0};
        else
          global_history_register <= {global_history_register[HISTORY_SIZE-2:0], train_taken};
      end
    end
  end

  // Outputs
  assign predict_taken = (predict_counter[1] == 2 || predict_counter[1] == 3);
  assign predict_history = predict_history_reg;

endmodule