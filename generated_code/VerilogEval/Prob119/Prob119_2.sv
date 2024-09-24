
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// State register
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Outputs logic
always @(*) begin
    case(state)
        A: begin
            if (in) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = C;
                out = 0;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        D: begin
            if (in) begin
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