
module TopModule (
    input  clk,
    input  areset,    // Asynchronous reset
    input  train_valid,
    input  train_taken,
    output reg [1:0] state  // 2-bit output for the counter
);

    // Define states for the counter
    parameter S0 = 2'b00;  // 0
    parameter S1 = 2'b01;  // 1 (weakly not-taken)
    parameter S2 = 2'b10;  // 2
    parameter S3 = 2'b11;  // 3 (maximum)

    // Asynchronous reset and counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;  // Reset to weakly not-taken (2'b01)
        end else if (train_valid) begin
            if (train_taken) begin
                // Increment
                if (state < S3) begin
                    state <= state + 1;
                end
            end else begin
                // Decrement
                if (state > S0) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule