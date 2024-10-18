
module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b0;  // Initializing state to OFF
        else begin
            case (state)
                2'b00: begin  // OFF state
                    if (j)
                        state <= 2'b01;  // Transition to ON state
                    else
                        state <= 2'b00;  // Remain in OFF state
                end

                2'b01: begin  // ON state
                    if (k)
                        state <= 2'b00;  // Transition to OFF state
                    else
                        state <= 2'b01;  // Remain in ON state
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out = 1'b0;  // OFF state, set out to 0
            2'b01: out = 1'b1;  // ON state, set out to 1
        endcase
    end

endmodule