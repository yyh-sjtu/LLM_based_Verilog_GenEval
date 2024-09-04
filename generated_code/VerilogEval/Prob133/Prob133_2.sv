
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define state variables
typedef enum logic [1:0] {
    A,
    B
} state_t;

// Define registers for state and next state
reg [1:0] state_reg, next_state_reg;

// Define counter for detecting two consecutive w = 1
reg [2:0] w_counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg <= A;
        next_state_reg <= A;
        w_counter <= 0;
        z <= 0;
    end else begin
        state_reg <= next_state_reg;
    end
end

// State transition and logic
always @* begin
    case(state_reg)
        A: begin
            if (s) begin
                next_state_reg = B;
            end else begin
                next_state_reg = A;
            end
        end
        B: begin
            if (w) begin
                w_counter <= w_counter + 1;
            end
            if (w_counter == 3) begin
                if (w_counter[1:0] == 2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
                w_counter <= 0;
            end
            next_state_reg = B;
        end
        default:
            next_state_reg = A;
    endcase
end

endmodule