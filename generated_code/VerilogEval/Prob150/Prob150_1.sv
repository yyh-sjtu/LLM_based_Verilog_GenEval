module includes the next-state logic and the output logic as derived from the state machine description you provided.

### TopModule Implementation

```systemverilog
module TopModule (
    input  logic d,
    input  logic done_counting,
    input  logic ack,
    input  logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // One-hot state extraction
    logic S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    assign {Wait, Count, B3, B2, B1, B0, S110, S11, S1, S} = state;

    // Next-state logic
    always_comb begin
        // Default next-state assignments
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        // State transition logic
        if (S) begin
            if (d) begin
                S1_next = 1'b1;
            end else begin
                S_next = 1'b1; // Stay in S
            end
        end else if (S1) begin
            if (d) begin
                S11_next = 1'b1;
            end else begin
                S_next = 1'b1; // Transition to S
            end
        end else if (S11) begin
            if (d) begin
                S11_next = 1'b1; // Stay in S11
            end else begin
                S110_next = 1'b1;
            end
        end else if (S110) begin
            if (d) begin
                B0_next = 1'b1; // Transition to B0
            end else begin
                S_next = 1'b1; // Transition to S
            end
        end else if (B0) begin
            B1_next = 1'b1; // Transition to B1
        end else if (B1) begin
            B2_next = 1'b1; // Transition to B2
        end else if (B2) begin
            B3_next = 1'b1; // Transition to B3
        end else if (B3) begin
            Count_next = 1'b1; // Transition to Count
        end else if (Count) begin
            if (done_counting) begin
                Wait_next = 1'b1; // Transition to Wait
            end else begin
                Count_next = 1'b1; // Stay in Count
            end
        end else if (Wait) begin
            if (ack) begin
                S_next = 1'b1; // Transition to S
            end else begin
                Wait_next = 1'b1; // Stay in Wait
            end
        end
    end

    // Output logic
    always_comb begin
        // Default outputs
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        if (Count) begin
            counting = 1'b1; // Output counting = 1 in Count state
        end
        if (Wait) begin
            done = 1'b1; // Output done = 1 in Wait state
        end
        if (B3) begin
            shift_ena = 1'b1; // Output shift_ena = 1 in B3 state
        end
        if (B2 || B1 || B0) begin
            shift_ena = 1'b1; // Continuous shift enable in B0, B1, B2 states
        end
    end

endmodule

