module top_module (
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state; // Current state of the FSM

    // Declare states
    parameter S_IDLE = 2'b00;
    parameter S_WAIT_1 = 2'b01;
    parameter S_WAIT_2 = 2'b10;
    parameter S_WAIT_3 = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE; // Reset state to IDLE
        end else begin
            case (state)
                S_IDLE:
                    if (data) begin
                        state <= S_WAIT_1; // Detect initial '1' in the sequence
                    end
                S_WAIT_1:
                    if (data) begin
                        state <= S_WAIT_2; // Detect '1' following the initial '1'
                    end else begin
                        state <= S_IDLE; // Reset state to IDLE if '1' is not detected
                    end
                S_WAIT_2:
                    if (!data) begin
                        state <= S_WAIT_3; // Detect '0' after the first two '1's
                    end else begin
                        state <= S_IDLE; // Reset state to IDLE if '0' is not detected
                    end
                S_WAIT_3:
                    if (data) begin
                        start_shifting <= 1; // Sequence found, set start_shifting to 1
                        state <= S_WAIT_1; // Reset state to wait for the next sequence
                    end else begin
                        state <= S_IDLE; // Reset state to IDLE if '1' is not detected
                    end
            endcase
        end
    end

endmodule

