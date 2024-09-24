
module TopModule (
    input wire clk,
    input wire reset,
    input wire w,
    output reg z
);
    // State Encoding
    reg [2:0] current_state, next_state;

    // State Definitions
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    // Next State Logic
    always @(*) begin
        case (current_state)
            A: begin
                if (w) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w) next_state = C;
                else next_state = D;
            end
            C: begin
                if (w) next_state = E;
                else next_state = D;
            end
            D: begin
                if (w) next_state = F;
                else next_state = A;
            end
            E: begin
                if (w) next_state = E;
                else next_state = D;
            end
            F: begin
                if (w) next_state = C;
                else next_state = D;
            end
            default: next_state = A; // Safe default
        endcase
    end

    // State Flip-Flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
            default: z = 0; // Safe default
        endcase
    end

endmodule