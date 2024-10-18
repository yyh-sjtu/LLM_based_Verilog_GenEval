module top_module(
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
     
    // Constants
    localparam INT_SIZE = 2;
    localparam PHT_SIZE = 128;
    localparam GH_SIZE = 7;
    localparam INDEX_SIZE = 7;
    localparam PC_SIZE = 7;

    // Registers
    reg [1:0] pht[PHT_SIZE-1:0];
    reg [GH_SIZE-1:0] gh;
    reg [GH_SIZE-1:0] new_gh;
    
    // Internal signals
    wire [INDEX_SIZE-1:0] index;
    wire [1:0] counter_val;
    reg predict_taken;
    reg [GH_SIZE-1:0] predict_history;
    
    // Hashing the global history
    assign index = predict_pc ^ (gh[GH_SIZE-1:0] & {GH_SIZE-2{1'b1}}); 
    
    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset all registers
            for (int i = 0; i < PHT_SIZE; i = i + 1)
                pht[i] <= 2'b11;
            gh <= 0;
        end else begin
            if (predict_valid) begin
                // Predict branch direction and history
                counter_val <= pht[index];
                case (counter_val)
                    2'b00: predict_taken <= 0;
                    2'b01: predict_taken <= 0;
                    2'b10: predict_taken <= 1;
                    2'b11: predict_taken <= 1;
                endcase
                predict_history <= gh;
            end
            
            if (train_valid) begin
                // Train branch predictor
                counter_val <= pht[index];
                case (counter_val)
                    2'b00:
                        if (train_taken) pht[index] <= 2'b01;
                    2'b01:
                        if (train_taken) pht[index] <= 2'b11;
                        else pht[index] <= 2'b00;
                    2'b10:
                        if (train_taken) pht[index] <= 2'b11;
                        else pht[index] <= 2'b01;
                    2'b11:
                        if (~train_taken) pht[index] <= 2'b10;
                endcase
                
                if (train_mispredicted) begin
                    // Recover branch history register
                    new_gh <= {gh[GH_SIZE-2:0], train_taken};
                    gh <= new_gh;
                end
            end
        end
    end
             
endmodule

