module fsm (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // Reset state A
        z <= 0;
    end else begin
        case (state)
            2'b00: begin // State A
                if (s == 1)
                    state <= 2'b01; // Move to state B
            end
            2'b01: begin // State B
                if (w == 1) // Check if w is 1 in the next three clock cycles
                    state <= 2'b10;
                else
                    state <= 2'b01;
            end
            2'b10: begin // Check w in the next three clock cycles
                if (w == 1)
                    state <= 2'b11;
                else
                    state <= 2'b01;
            end
            2'b11: begin // Check w in the next three clock cycles
                if (w == 1)
                    z <= 1; // Set output z to 1
                else
                    z <= 0; // Set output z to 0
                state <= 2'b01;
            end
            default: state <= 2'b00;
        endcase
    end
end

endmodule

