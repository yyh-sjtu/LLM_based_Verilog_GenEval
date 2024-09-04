
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire x,
    output reg  z
);

    // State declarations using one-hot encoding
    reg [1:0] state; // 2 bits are enough for 2 states in one-hot encoding
    parameter A = 2'b01; // State A
    parameter B = 2'b10; // State B
  
    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // Reset to state A
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B; // Transition to B
                    end
                    // If x=0, remain in A
                end
                B: begin
                    if (x) begin
                        state <= B; // Remain in B
                    end
                    // If x=0, remain in B
                end
            endcase
        end
    end

    // Combinational logic for output z based on the current state and input x
    always @(*) begin
        case (state)
            A: begin
                z = x; // z = 1 when in state A and x=1, else z=0
            end
            B: begin
                z = ~x; // z = 1 when in state B and x=0, else z=0
            end
            default: z = 0; // Default case
        endcase
    end
   
endmodule