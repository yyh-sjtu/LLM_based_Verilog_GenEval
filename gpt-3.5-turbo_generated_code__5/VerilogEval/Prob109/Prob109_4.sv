
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// Define state variables
reg state;

// State machine logic
always @ (posedge clk) begin
    if (areset) begin
        state <= 1'b0; // Reset to state B
    end else begin
        case(state)
            1'b0: begin // State A
                if (in) begin
                    state <= 1'b0; // A (0) --1--> A
                end else begin
                    state <= 1'b1; // A (0) --0--> B
                end
            end
            1'b1: begin // State B
                if (in) begin
                    state <= 1'b1; // B (1) --1--> B
                end else begin
                    state <= 1'b0; // B (1) --0--> A
                end
            end
            default: state <= 1'b0;
        endcase
    end
end

// Output logic
always @* begin
    out = state;
end

endmodule