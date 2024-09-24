
module TopModule (
    input wire clk,
    input wire reset,
    input wire x,
    output reg z
);
    // State encoding using 3 bits
    parameter STATE_000 = 3'b000;
    parameter STATE_001 = 3'b001;
    parameter STATE_010 = 3'b010;
    parameter STATE_011 = 3'b011;
    parameter STATE_100 = 3'b100;

    // Current state declaration
    reg [2:0] current_state, next_state;

    // Synchronous reset and state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_000; // Reset state
        end else begin
            current_state <= next_state; // Next state on clock edge
        end
    end

    // Next state logic based on present state and input
    always @(*) begin
        case (current_state)
            STATE_000: next_state = (x == 0) ? STATE_000 : STATE_001;
            STATE_001: next_state = (x == 0) ? STATE_001 : STATE_100;
            STATE_010: next_state = (x == 0) ? STATE_010 : STATE_001;
            STATE_011: next_state = (x == 0) ? STATE_001 : STATE_010;
            STATE_100: next_state = (x == 0) ? STATE_011 : STATE_100;
            default: next_state = STATE_000; // Default to reset state
        endcase
    end

    // Output logic based on present state
    always @(*) begin
        case (current_state)
            STATE_000: z = 0;
            STATE_001: z = 0;
            STATE_010: z = 0;
            STATE_011: z = 1;
            STATE_100: z = 1;
            default: z = 0; // Default to 0 for safety
        endcase
    end
endmodule