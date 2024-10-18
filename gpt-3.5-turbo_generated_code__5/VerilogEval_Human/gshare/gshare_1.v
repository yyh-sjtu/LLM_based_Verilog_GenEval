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

// Internal signals
reg [6:0] branch_history;
reg [1:0] counter_table [0:127];

// Predict logic
reg predict_taken_internal;
reg [6:0] predict_history_internal;
reg [6:0] hash_index;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history <= 0;
    end else if (predict_valid) begin
        hash_index <= predict_pc ^ (branch_history & 0x7f);
        predict_taken_internal <= counter_table[hash_index] > 1;
        predict_history_internal <= branch_history;
    end else if (train_valid && !train_mispredicted) begin
        hash_index <= train_pc ^ (train_history & 0x7f);
        predict_taken_internal <= counter_table[hash_index] > 1;
        predict_history_internal <= branch_history;
    end
end

assign predict_taken = predict_taken_internal;
assign predict_history = predict_history_internal;

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history <= 0;
    end else if (train_valid) begin
        if (train_mispredicted) begin
            branch_history <= train_history;
        end
        counter_table[hash_index] <= saturating_counter(train_taken, counter_table[hash_index]);
    end
end

// Saturating counter function
function [1:0] saturating_counter;
    input taken;
    input [1:0] counter;
    begin
        case (counter)
            2'b00: begin
                if (taken) begin
                    return 2'b01;
                end else begin
                    return 2'b00;
                end
            end
            2'b01: begin
                if (taken) begin
                    return 2'b11;
                end else begin
                    return 2'b00;
                end
            end
            2'b10: begin
                if (taken) begin
                    return 2'b11;
                end else begin
                    return 2'b01;
                end
            end
            2'b11: begin
                if (taken) begin
                    return 2'b11;
                end else begin
                    return 2'b10;
                end
            end
        endcase
    end
endfunction

endmodule

