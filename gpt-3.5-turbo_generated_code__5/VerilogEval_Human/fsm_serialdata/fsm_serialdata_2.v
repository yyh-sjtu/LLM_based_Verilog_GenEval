module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

    // Define the states
    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        WAIT_FOR_STOP
    } State;

    // Define the signals
    reg        clk_prev;
    reg        reset_prev;
    reg        in_prev;
    reg [7:0]  received_byte;
    State      current_state;
    State      next_state;

    always_ff @(posedge clk) begin
        if (reset == 1'b1) begin
            clk_prev <= 0;
            reset_prev <= 1;
            in_prev <= 0;
            received_byte <= 0;
            current_state <= IDLE;
            next_state <= IDLE;
        end else begin
            clk_prev <= clk;
            reset_prev <= reset;
            in_prev <= in;
            current_state <= next_state;
        end
    end

    always_comb begin
        out_byte <= received_byte;
        done <= (reset_prev == 1 && reset == 0 && current_state == STOP_BIT);
        
        case (current_state)
            IDLE: begin
                next_state = START_BIT;
                received_byte = 0;
            end
            START_BIT: begin
                if (in_prev == 0 && in == 1) begin
                    next_state = DATA_BITS;
                    received_byte = 0;
                end else begin
                    next_state = START_BIT;
                end
            end
            DATA_BITS: begin
                if (in_prev == 1 && in == 0) begin
                    next_state = DATA_BITS;
                    received_byte = received_byte << 1;
                end else if (in_prev == 0 && in == 1) begin
                    next_state = DATA_BITS;
                    received_byte = (received_byte << 1) | 1;
                end else if (in_prev == 1 && in == 1) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = START_BIT;
                end
            end
            STOP_BIT: begin
                if (in_prev == 1 && in == 1) begin
                    next_state = WAIT_FOR_STOP;
                end else begin
                    next_state = START_BIT;
                end
            end
            WAIT_FOR_STOP: begin
                if (in_prev == 1 && in == 1) begin
                    next_state = WAIT_FOR_STOP;
                end else begin
                    next_state = START_BIT;
                    received_byte = 0;
                end
            end
        endcase
    end
endmodule

