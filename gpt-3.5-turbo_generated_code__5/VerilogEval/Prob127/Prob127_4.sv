
module TopModule (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
    );
    
    // Define the states
    typedef enum logic [1:0] {LEFT, RIGHT} State;
    reg [1:0] current_state, next_state;
    
    // Assign the initial state
    initial begin
        current_state = LEFT;
    end
    
    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end
    
    // Combinational logic
    always @(*) begin
        case (current_state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
                if (bump_right && !bump_left)
                    next_state = RIGHT;
                else if (bump_right && bump_left)
                    next_state = RIGHT;
                else if (!bump_right && !bump_left)
                    next_state = LEFT;
            end
            
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                if (bump_left && !bump_right)
                    next_state = LEFT;
                else if (bump_left && bump_right)
                    next_state = LEFT;
                else if (!bump_left && !bump_right)
                    next_state = RIGHT;
            end
        endcase
    end
endmodule
