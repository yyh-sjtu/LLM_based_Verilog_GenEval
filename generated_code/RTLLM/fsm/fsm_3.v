
module fsm (
    input IN,
    input CLK,
    input RST,
    output reg MATCH
);

// FSM states
parameter S0 = 2'b00; // Initial state
parameter S1 = 2'b01; // State after receiving first '1'
parameter S2 = 2'b10; // State after receiving '10'
parameter S3 = 2'b11; // State after receiving '100'
parameter S4 = 2'b12; // State after receiving '1001' and MATCH is 1
parameter S5 = 2'b13; // State after receiving '10011' and MATCH is 1

// Declare state register
reg [1:0] state, next_state;

// Combinational logic block
always @(*) begin
    next_state = state; // Default next state is current state
    
    case(state)
        S0: begin
            if(IN == 1)
                next_state = S1;
        end
        
        S1: begin
            if(IN == 0)
                next_state = S2;
            else
                next_state = S0;
        end
        
        S2: begin
            if(IN == 0)
                next_state = S3;
            else
                next_state = S0;
        end
        
        S3: begin
            if(IN == 1)
                next_state = S4;
            else
                next_state = S0;
        end
        
        S4: begin
            if(IN == 1)
                next_state = S5;
            else if(IN == 0)
                next_state = S3;
            else
                next_state = S0;
        end
        
        S5: begin
            if(IN == 1)
                next_state = S5;
            else if(IN == 0)
                next_state = S3;
            else
                next_state = S0;
        end
    endcase
end

// State register with synchronous reset
always @(posedge CLK or posedge RST) begin
    if(RST)
        state <= S0;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    if(state == S4 || state == S5)
        MATCH = 1;
    else
        MATCH = 0;
end

endmodule