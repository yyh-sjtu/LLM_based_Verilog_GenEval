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
    wire [7:0] gshare_pc;
    wire [7:0] gshare_global_history;
    assign gshare_pc = predict_pc ^ {2'd0, prediction_valid};
    assign predict_taken = gshare_pc[7] ^ gshare_global_history[0];
    assign predict_history = gshare_global_history[6:1] ^ gshare_pc[2:0];
    assign gshare_global_history[0] = predict_pc ^ {2'd0, prediction_valid};
endmodule

