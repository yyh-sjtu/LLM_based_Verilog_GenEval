
module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

// Define the states of the FSM
typedef enum logic [3:0] {
    S0, // Initial state
    S1, // Input is 1
    S2, // Input is 0
    S3, // Input is 0
    S4, // Input is 1
    S5  // Input is 1
} state;

// Declare state and next_state variables
reg [3:0] state, next_state;

// Define the logic for the next state based on the current state and input
always @(*) begin
    case(state)
        S0: next_state = (IN == 1) ? S1 : S0;
        S1: next_state = (IN == 0) ? S2 : S1;
        S2: next_state = (IN == 0) ? S3 : S0;
        S3: next_state = (IN == 1) ? S4 : S0;
        S4: next_state = (IN == 1) ? S5 : S0;
        S5: next_state = (IN == 1) ? S5 : S0;
        default: next_state = S0;
    endcase
end

// State transition logic
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= S0;
        MATCH <= 0;
    end else begin
        state <= next_state;
        if (state == S5) begin
            MATCH <= 1;
        end else begin
            MATCH <= 0;
        end
    end
end

endmodule