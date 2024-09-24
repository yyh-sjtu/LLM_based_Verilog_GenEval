
module TopModule (
    input clk,
    input reset,
    input data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input ack
);

    // State Declaration
    typedef enum reg [2:0] {
        IDLE,
        DETECT,
        SHIFT,
        COUNT,
        WAIT_DONE
    } state_t;

    state_t current_state, next_state;

    // Registers for time counting
    reg [3:0] delay;       // 4 bits for delay
    reg [19:0] counter;    // Counter for 1000 cycles
    reg [3:0] time_left;   // Remaining time

    // State Transition (synchronous)
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counting <= 0;
            count <= 4'b0000;
            done <= 0;
            delay <= 4'b0000;
            time_left <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                next_state = DETECT;  // Start in detection state
            end

            DETECT: begin
                if (data == 1'b1) begin
                    next_state = (current_state == 0) ? SHIFT : DETECT; // Track bits
                end else begin
                    next_state = (data == 1'b0) ? DETECT :  DETECT;  // Stay in detect
                end
            end

            SHIFT: begin
                if (count < 4) begin
                    next_state = SHIFT; // Continue shifting in the delay bits
                end else begin
                    next_state = COUNT; // Move to counting state
                end
            end

            COUNT: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    next_state = COUNT; // Keep counting
                end else begin
                    next_state = WAIT_DONE; // Finish counting
                end
            end

            WAIT_DONE: begin
                if (ack) begin
                    next_state = IDLE; // Wait for ack to reset
                end else begin
                    next_state = WAIT_DONE; // Stay in wait
                end
            end

            default: next_state = IDLE; // Safety default
        endcase
    end

    // Outputs and counting logic
    always @(posedge clk) begin
        if (current_state == DETECT) begin
            // Shift in a 4-bit delay once the pattern 1101 is confirmed
            // Logic for shift in will be added based on how we parse bits.
            // This would involve checking previous state to make sure
            // most significant bit is stored first.
            // The shifting logic here is dependent on the order of bits
        end

        if (current_state == COUNT) begin
            counter <= counter + 1;
            // Manage time_left based on counter value
            if (counter % 1000 == 0) begin
                time_left <= time_left - 1;
            end
            // Update the count output
            count <= time_left;
        end

        if (current_state == WAIT_DONE) begin
            done <= 1; // Indicate done status
        end else begin
            done <= 0; // Reset done
        end

        // Implement reset, on delay logic and further flags 
        // according to the state of the machine.
    end

endmodule