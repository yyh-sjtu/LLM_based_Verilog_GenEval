
module TopModule (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    reg [2:0] state, next_state;

    // State encoding
    localparam STATE_000 = 3'b000,
               STATE_001 = 3'b001,
               STATE_010 = 3'b010,
               STATE_011 = 3'b011,
               STATE_100 = 3'b100;

    // Sequential logic: update state on clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_000; // Reset to state 000
        end else begin
            state <= next_state; // Transition to the next state
        end
    end

    // Combinational logic: determine next state and output
    always @(*) begin
        case (state)
            STATE_000: begin
                if (x) begin
                    next_state = STATE_001;
                end else begin
                    next_state = STATE_000;
                end
                z = 1'b0; // Output is 0
            end
            
            STATE_001: begin
                if (x) begin
                    next_state = STATE_100;
                end else begin
                    next_state = STATE_001;
                end
                z = 1'b0; // Output is 0
            end
            
            STATE_010: begin
                if (x) begin
                    next_state = STATE_001;
                end else begin
                    next_state = STATE_010;
                end
                z = 1'b0; // Output is 0
            end
            
            STATE_011: begin
                if (x) begin
                    next_state = STATE_010;
                end else begin
                    next_state = STATE_001;
                end
                z = 1'b1; // Output is 1
            end
            
            STATE_100: begin
                if (x) begin
                    next_state = STATE_100;
                end else begin
                    next_state = STATE_011;
                end
                z = 1'b1; // Output is 1
            end
            
            default: begin
                next_state = STATE_000; // Default to state 000
                z = 1'b0; // Output is 0
            end
        endcase
    end
    
endmodule