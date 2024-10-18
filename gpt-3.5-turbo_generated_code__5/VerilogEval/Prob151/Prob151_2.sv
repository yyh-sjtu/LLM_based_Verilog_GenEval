
module TopModule(
    input  clk,
    input  reset,
    input  data,
    input  done_counting,
    input  ack,
    output shift_ena,
    output counting,
    output done
);
    
    // State definition
    enum {IDLE, SHIFT_ENABLE, WAIT_COUNTING, NOTIFY, WAIT_ACK} state;

    // Registers
    reg [3:0] shiftCount;
    reg [3:0] delayCount;

    // Outputs
    assign shift_ena = (state == SHIFT_ENABLE);
    assign counting = (state == WAIT_COUNTING);
    assign done = (state == NOTIFY);

    // Next state logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shiftCount <= 0;
            delayCount <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 1 && delayCount == 3'b011) begin
                        state <= SHIFT_ENABLE;
                        shiftCount <= 0;
                    end else begin
                        state <= IDLE;
                        if (data == 1 && delayCount == 3'b001)
                            delayCount <= 0;
                        else if (data == 1)
                            delayCount <= delayCount + 1;
                    end
                SHIFT_ENABLE:
                    state <= WAIT_COUNTING;
                WAIT_COUNTING:
                    if (done_counting)
                        state <= NOTIFY;
                    else
                        state <= WAIT_COUNTING;
                NOTIFY:
                    if (ack)
                        state <= WAIT_ACK;
                    else
                        state <= NOTIFY;
                WAIT_ACK:
                    state <= IDLE;
            endcase
        end
    end

endmodule