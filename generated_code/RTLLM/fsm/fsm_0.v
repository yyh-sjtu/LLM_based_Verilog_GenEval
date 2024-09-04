
module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

// Define states for the FSM
parameter IDLE = 2'd0;
parameter STATE1 = 2'd1;
parameter STATE2 = 2'd2;
parameter STATE3 = 2'd3;
parameter STATE4 = 2'd4;
parameter STATE5 = 2'd5;
parameter STATE6 = 2'd6;
parameter STATE7 = 2'd7;
parameter STATE8 = 2'd8;

// Define signals for the FSM
reg [1:0] state, next_state;

// Define a counter to keep track of the number of input signals
reg [3:0] input_count;

always @ (posedge CLK or posedge RST) begin
    if (RST) begin
        state <= IDLE;
        input_count <= 0;
        MATCH <= 0;
    end else begin
        state <= next_state;
        input_count <= input_count + 1;
    end
end

always @ (*) begin
    next_state = state;
    MATCH = 0;

    case (state)
        IDLE: begin
            if (IN == 1) begin
                next_state = STATE1;
                input_count <= 0;
            end
        end
        STATE1: begin
            if (IN == 0) begin
                next_state = STATE2;
            end
        end
        STATE2: begin
            if (IN == 0) begin
                next_state = STATE3;
            end
        end
        STATE3: begin
            if (IN == 1) begin
                next_state = STATE4;
            end
        end
        STATE4: begin
            if (IN == 1) begin
                next_state = STATE5;
            end
        end
        STATE5: begin
            if (IN == 1) begin
                next_state = STATE6;
            end
        end
        STATE6: begin
            if (IN == 0) begin
                next_state = STATE7;
            end
        end
        STATE7: begin
            if (IN == 0) begin
                next_state = STATE8;
            end
        end
        STATE8: begin
            if (IN == 1) begin
                MATCH = (input_count == 4) || (input_count == 8);
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule