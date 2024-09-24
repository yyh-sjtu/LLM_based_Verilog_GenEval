
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// Define state enum
typedef enum logic [1:0] {
    B,
    A
} state_type;

// Define state register and initialize to B
reg [1:0] state_reg = B;

// State machine logic
always @(posedge clk or posedge reset)
begin
    if (reset) begin
        state_reg <= B;
    end else begin
        case(state_reg)
            B: begin
                out <= 1;
                if (in) begin
                    state_reg <= B;
                end else begin
                    state_reg <= A;
                end
            end
            A: begin
                out <= 0;
                if (in) begin
                    state_reg <= A;
                end else begin
                    state_reg <= B;
                end
            end
            default: state_reg <= B;
        endcase
    end
end

endmodule