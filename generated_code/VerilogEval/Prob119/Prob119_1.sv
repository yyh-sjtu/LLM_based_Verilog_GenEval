
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// State declaration
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Flip-flop to store the current state
reg [1:0] state, next_state;

// Moore state machine logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// State transition and output logic
always @* begin
    case (state)
        A: begin
            if (in == 1) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        B: begin
            if (in == 1) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = C;
                out = 0;
            end
        end
        C: begin
            if (in == 1) begin
                next_state = D;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        D: begin
            if (in == 1) begin
                next_state = B;
                out = 1;
            end else begin
                next_state = C;
                out = 0;
            end
        end
    endcase
end

endmodule