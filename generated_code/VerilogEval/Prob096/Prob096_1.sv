
module TopModule (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define states for the finite state machine
parameter IDLE = 2'b00;
parameter STATE1 = 2'b01;
parameter STATE2 = 2'b10;
parameter FINISHED = 2'b11;

// Initialize state register
reg [1:0] state, next_state;

// Sequential logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Combinational logic
always @(*) begin
    case (state)
        IDLE: begin
            if (data) begin
                next_state = STATE1;
            end else begin
                next_state = IDLE;
            end
        end
        STATE1: begin
            if (data) begin
                next_state = STATE2;
            end else begin
                next_state = IDLE;
            end
        end
        STATE2: begin
            if (data) begin
                next_state = FINISHED;
            end else begin
                next_state = IDLE;
            end
        end
        FINISHED: begin
            next_state = FINISHED;
        end
    endcase
end

// Output logic
always @(*) begin
    if (state == FINISHED) begin
        start_shifting = 1;
    end else begin
        start_shifting = 0;
    end
end

endmodule