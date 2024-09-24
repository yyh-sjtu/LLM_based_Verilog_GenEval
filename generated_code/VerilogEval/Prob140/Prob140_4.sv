
module TopModule (
    input       clk,
    input       reset,
    input       in,
    output reg  disc,
    output reg  flag,
    output reg  err
);

// State encoding
typedef enum logic [2:0] {
    IDLE,       // Initial state, after reset or after processing a frame
    ONE,        // Saw one '1'
    TWO,        // Saw two '1's
    THREE,      // Saw three '1's
    FOUR,       // Saw four '1's
    FIVE,       // Saw five '1's
    DISCARD,    // This state means we detected 0111110, need to discard next bit
    FLAG,       // This state means we detected 01111110, a flag is seen
    ERROR       // This state means more than 6 consecutive '1's
} state_t;

state_t current_state, next_state;

// Output logic
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic and output generation
always_ff @(posedge clk) begin
    if (reset) begin
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        case (current_state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= ONE;
                end else begin
                    next_state <= IDLE; // Remain in IDLE on '0'
                end
            end
            
            ONE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= TWO;
                end else begin
                    next_state <= IDLE; 
                end
            end
            
            TWO: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= THREE;
                end else begin
                    next_state <= IDLE; 
                end
            end
            
            THREE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= FOUR;
                end else begin
                    next_state <= IDLE; 
                end
            end
            
            FOUR: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= FIVE;
                end else begin
                    next_state <= IDLE; 
                end
            end
            
            FIVE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= FLAG; // Move to FLAG state on another '1'
                end else begin
                    next_state <= DISCARD; // Move to DISCARD state on '0'
                end
            end
            
            DISCARD: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
                next_state <= IDLE; // After discarding, go back to IDLE
            end
            
            FLAG: begin
                disc <= 0;
                flag <= 1; // Assert flag for a full cycle
                err <= 0;
                next_state <= IDLE; // Reset to IDLE after flag is set
            end
            
            ERROR: begin
                disc <= 0;
                flag <= 0;
                err <= 1; // Assert error for a full cycle
                next_state <= IDLE; // Move back to IDLE
            end
            
            default: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                next_state <= IDLE; // Reset to IDLE on unknown state
            end
        endcase
    end
end

endmodule