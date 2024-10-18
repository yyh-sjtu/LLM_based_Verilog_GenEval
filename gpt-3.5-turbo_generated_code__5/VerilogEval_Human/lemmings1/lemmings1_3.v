module lemming_fsm (
    input clk,
    input areset,
    input bump_left, 
    input bump_right, 
    output walk_left, 
    output walk_right
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Start in walk_left state
        end else begin
            case(state)
                2'b01: begin // current state is walk_left
                    if (bump_right) begin
                        state <= 2'b10; // Change to walk_right state
                    end 
                end
                2'b10: begin // current state is walk_right
                    if (bump_left) begin
                        state <= 2'b01; // Change to walk_left state
                    end 
                end
                default: state <= state; // Do nothing for other cases
            endcase
        end
    end
    
    assign walk_left = (state == 2'b01) ? 1'b1 : 1'b0;
    assign walk_right = (state == 2'b10) ? 1'b1 : 1'b0;
    
endmodule

