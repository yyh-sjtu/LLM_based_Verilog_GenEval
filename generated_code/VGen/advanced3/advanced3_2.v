module
module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
);

    // Defining the states
    parameter IDLE = 2'd0;
    parameter S1 = 2'd1;
    parameter S10 = 2'd2;
    parameter S101 = 2'd3;

    // Defining present and next state registers
    reg [1:0] present_state, next_state;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= IDLE;
        end else begin
            present_state <= next_state;
        end

        case(present_state)
            IDLE: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
            end

            S1: begin
                if (!x) begin
                    next_state = S10;
                end else begin
                    next_state = IDLE;
                end
            end

            S10: begin
                if (x) begin
                    next_state = S101;
                end else begin
                    next_state = IDLE;
                end
            end

            S101: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    assign z = (present_state == S101);

endmodule

