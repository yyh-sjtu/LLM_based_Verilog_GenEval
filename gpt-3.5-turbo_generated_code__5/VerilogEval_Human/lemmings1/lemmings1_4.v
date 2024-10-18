module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
parameter WAIT = 0;
parameter LEFT = 1;
parameter RIGHT = 2;

// Define the current state variable
reg [1:0] state;

// Sequential logic
always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= LEFT; // Reset state to walking left
    else
    begin
        case (state)
            WAIT:
                if (bump_left && !bump_right) // Bumped on the left
                    state <= RIGHT; // Transition to walking right
                else if (!bump_left && bump_right) // Bumped on the right
                    state <= LEFT; // Transition to walking left
                else if (bump_left && bump_right) // Bumped on both sides
                    state <= RIGHT; // Transition to walking right
                else
                    state <= WAIT; // Stay in wait state
            LEFT:
                if (bump_left && !bump_right) // Bumped on the left
                    state <= RIGHT; // Transition to walking right
                else if (bump_left && bump_right) // Bumped on both sides
                    state <= RIGHT; // Transition to walking right
                else
                    state <= LEFT; // Stay in walking left state
            RIGHT:
                if (!bump_left && bump_right) // Bumped on the right
                    state <= LEFT; // Transition to walking left
                else if (bump_left && bump_right) // Bumped on both sides
                    state <= LEFT; // Transition to walking left
                else
                    state <= RIGHT; // Stay in walking right state
        endcase
    end
end

// Combinational logic for outputs
always @(state)
begin
    // Update output signals
    case (state)
        WAIT:
            begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        LEFT:
            begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        RIGHT:
            begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
    endcase
end

endmodule

