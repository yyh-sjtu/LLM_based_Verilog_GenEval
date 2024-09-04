
module TopModule (
    input  clk,
    input  reset,
    input  data,
    input  done_counting,
    input  ack,
    output shift_ena,
    output counting,
    output reg done
);

// Define states for the finite-state machine
parameter START = 2'b00;
parameter SHIFTING = 2'b01;
parameter WAITING = 2'b10;
reg [1:0] state;

// Internal signals
reg pattern_detected;
reg [3:0] shift_count;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= START;
        pattern_detected <= 1'b0;
        shift_count <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            START: begin
                if (data == 1 && !pattern_detected) begin
                    pattern_detected <= 1'b1;
                end else if (pattern_detected) begin
                    state <= SHIFTING;
                    shift_count <= 4'b0;
                end
            end

            SHIFTING: begin
                if (shift_count < 4) begin
                    shift_count <= shift_count + 1;
                end else begin
                    state <= WAITING;
                    counting <= 1'b1;
                end
            end

            WAITING: begin
                if (done_counting) begin
                    done <= 1'b1;
                    if (ack) begin
                        state <= START;
                        pattern_detected <= 1'b0;
                    end
                end
            end
        endcase
    end
end

// Assign shift_ena output
assign shift_ena = (state == SHIFTING);

endmodule