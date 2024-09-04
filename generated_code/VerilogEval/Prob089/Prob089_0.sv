
module TopModule (
    input  clk,
    input  areset,
    input  x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        ADD_ONE = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Registers to store intermediate results and carry
    reg [31:0] inverted_result; // A large enough size to handle arbitrary length inputs
    reg [31:0] stored_result;
    reg carry;

    // Edge-triggered logic block
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            inverted_result <= 0;
            stored_result <= 0;
            z <= 0;

        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output generation
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = INVERT; // Start inverting when reset is released
                    z = 0;               // Output defined by state (Moore)
                end else begin
                    next_state = IDLE;
                    z = z;               // Maintain output
                end
            end

            INVERT: begin
                inverted_result = (inverted_result << 1) | ~x; // Shift left and invert x
                next_state = ADD_ONE; // Move to add one after inverting
                z = 0;               // Keep output same
            end

            ADD_ONE: begin
                stored_result = inverted_result + 1; // Add one to the inverted_result
                if (stored_result[31]) begin           // If there's a carry-out
                    z = 1;                            // Set output z to 1
                end else begin
                    z = 0;                            // Otherwise output is 0
                end
                next_state = INVERT; // Go back to INVERT state to ready for another input
            end

            default: begin
                next_state = IDLE; // Default to IDLE to avoid latches
                z = 0;            // Default output
            end
        endcase
    end

endmodule