
module TopModule (
    input  clk,
    input  areset,
    input  j,
    input  k,
    output reg out
);

    // State Encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Asynchronous Reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
            out <= 0; // Ensures out is reset when entering OFF
        end else begin
            current_state <= next_state;
        end
    end

    // Output Logic (Moore Machine)
    always_ff @(current_state) begin
        case (current_state)
            OFF: out = 0;
            ON:  out = 1;
            default: out = 0; // Safe default state
        endcase
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF; // Safe default
        endcase
    end

endmodule