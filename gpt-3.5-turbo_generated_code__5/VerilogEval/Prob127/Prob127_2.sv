
module TopModule(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define the states of the finite state machine
    reg [1:0] state;
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    
    // Define the outputs of the finite state machine
    reg walk_left_reg;
    reg walk_right_reg;
    
    // Sequential logic triggered on positive edge of the clock
    always @(posedge clk or posedge areset)
    begin
        if(areset) // Asynchronous reset
        begin
            state <= WALK_LEFT; // Reset state to walk left
        end
        else // State transitions and outputs
        begin
            case(state)
                WALK_LEFT: // Current state is walk left
                    begin
                        if(bump_right) // Bumped on the right
                            state <= WALK_RIGHT; // Transition to walk right
                        else
                            state <= WALK_LEFT; // Stay in the same state
                        
                        walk_left_reg <= 1; // Lemming walks left
                        walk_right_reg <= 0;
                    end
                
                WALK_RIGHT: // Current state is walk right
                    begin
                        if(bump_left) // Bumped on the left
                            state <= WALK_LEFT; // Transition to walk left
                        else
                            state <= WALK_RIGHT; // Stay in the same state
                        
                        walk_left_reg <= 0;
                        walk_right_reg <= 1; // Lemming walks right
                    end
            endcase
        end
    end
    
    // Assign the outputs of the finite state machine to the module outputs
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;

endmodule