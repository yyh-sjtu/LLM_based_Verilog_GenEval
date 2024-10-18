
module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    parameter IDLE = 2'b00;      // Initial state
    parameter CHECKING_1 = 2'b01; // Checking for 6 consecutive 1s
    parameter CHECKING_0 = 2'b10; // Checking for zero after 5 1s

    reg [1:0] state, next_state;

    reg [2:0] count_ones;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count_ones <= 3'b0;
        end else begin
            state <= next_state;
            count_ones <= {count_ones[1:0], in};
        end
    end

    always @* begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case(state)
            IDLE: begin
                if(in == 1'b1) begin
                    next_state = CHECKING_1;
                end else begin
                    next_state = IDLE;
                end
            end

            CHECKING_1: begin
                if(in == 1'b1) begin
                    if(count_ones == 3'b111) begin
                        next_state = CHECKING_0;
                    end else if(count_ones == 3'b111) begin
                        next_state = err;
                    end else begin
                        next_state = CHECKING_1;
                    end
                end else begin
                    next_state = IDLE;
                end
            end

            CHECKING_0: begin
                if(in == 1'b0) begin
                    flag = 1'b1;
                    next_state = IDLE;
                end else if(in == 1'b1) begin
                    disc = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE;
                end
            end

            default: begin
                err = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule