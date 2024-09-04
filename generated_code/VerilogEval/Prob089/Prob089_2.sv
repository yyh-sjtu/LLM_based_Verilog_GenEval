
module TopModule (
    input  clk,
    input  areset,
    input  x,
    output reg z
);

    // State definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,  // Initial state before input is processed
        READ = 2'b01,  // Reading bits
        COMPLEMENT = 2'b10, // Generating the 2's complement
    } state_t;

    // State and next state variables
    state_t current_state, next_state;

    // Registers for internal computations
    reg [31:0] number;     // Assume a maximum size of 32 bits for input
    reg [31:0] complement; // To hold the 2's complement value
    reg [4:0] bit_count;   // Count the number of bits processed

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            bit_count <= 0;
            z <= 0;
            number <= 0;
            complement <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == READ) begin
                number[bit_count] <= x; // Shift in the x bit
                bit_count <= bit_count + 1;
            end else if (current_state == COMPLEMENT) begin
                complement <= ~number + 1; // 2's complement
                z <= complement[0]; // Output the LSB of the complement
            end
        end
    end

    // State machine logic
    always @(*) begin
        // Default next state
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = READ; // Start reading when reset is released
                end
            end

            READ: begin
                if (bit_count == 32) begin // Stop after processing 32 bits
                    next_state = COMPLEMENT;
                end
            end

            COMPLEMENT: begin
                // Once the complement is done, we can go back to IDLE
                next_state = IDLE;
            end
        endcase
    end

endmodule