
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// State definition
parameter B = 1'b1;
parameter A = 1'b0;
reg state;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
    end else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                end else begin
                    state <= B;
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    out = state;
end

endmodule