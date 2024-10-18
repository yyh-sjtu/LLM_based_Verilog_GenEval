module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states of the state machine
    typedef enum logic [2:0] {
        SEARCH_PATTERN,
        SHIFT_ENA,
        WAIT_COUNTING,
        NOTIFY_USER,
        WAIT_ACK
    } state_t;

    // Declare state and next_state variables
    state_t state;
    state_t next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SEARCH_PATTERN;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (state)
            SEARCH_PATTERN:
                if (data == 4'b1101) begin
                    next_state = SHIFT_ENA;
                end
            SHIFT_ENA:
                shift_ena = 1;
                next_state = WAIT_COUNTING;
            WAIT_COUNTING:
                counting = 1;
                if (done_counting) begin
                    next_state = NOTIFY_USER;
                end
            NOTIFY_USER:
                done = 1;
                next_state = WAIT_ACK;
            WAIT_ACK:
                if (ack) begin
                    next_state = SEARCH_PATTERN;
                end
            default:
                next_state = SEARCH_PATTERN;
        endcase
    end

endmodule

