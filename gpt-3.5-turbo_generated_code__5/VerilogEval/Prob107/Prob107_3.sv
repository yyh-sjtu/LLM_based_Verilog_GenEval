
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// Define states
parameter B = 2'b00;
parameter A = 2'b01;

// Define state register
reg [1:0] state, next_state;

// Define state transition and output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
        out <= 1;
    end else begin
        state <= next_state;
        case(state)
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            A: begin
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
        endcase
    end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule