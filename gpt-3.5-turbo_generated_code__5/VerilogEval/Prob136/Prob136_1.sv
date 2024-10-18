
module TopModule (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define state enum
typedef enum logic [2:0] {
    A, B, C, D, E, F
} StateType;

// Define state register and next state logic
reg [2:0] currentState, nextState;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        currentState <= A;
    end else begin
        currentState <= nextState;
    end
end

always @* begin
    case(currentState)
        A: begin
            if (w)
                nextState = A;
            else
                nextState = B;
        end
        B: begin
            if (w)
                nextState = D;
            else
                nextState = C;
        end
        C: begin
            if (w)
                nextState = D;
            else
                nextState = E;
        end
        D: begin
            if (w)
                nextState = A;
            else
                nextState = F;
        end
        E: begin
            if (w)
                nextState = D;
            else
                nextState = E;
        end
        F: begin
            if (w)
                nextState = D;
            else
                nextState = C;
        end
    endcase
end

// Output logic
always @* begin
    case(currentState)
        A: z = 1'b0;
        B: z = 1'b0;
        C: z = 1'b0;
        D: z = 1'b0;
        E: z = 1'b1;
        F: z = 1'b1;
    endcase
end

endmodule