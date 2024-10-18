module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset state A
        z <= 0; // Reset output z
    end else begin
        case (state)
            2'b00:  // State A
                begin
                    if (s == 1) begin
                        state <= 2'b01; // Move to state B
                    end
                end

            2'b01: // State B
                begin
                    if (w == 1) begin
                        state <= 2'b10; // Move to state C
                    end
                end

            2'b10: // State C
                begin
                    if (w == 1) begin
                        state <= 2'b11; // Move to state D
                    end else begin
                        state <= 2'b01; // Move back to state B
                    end
                end

            2'b11: // State D
                begin
                    if (w == 1) begin
                        state <= 2'b10; // Move back to state C
                    end else begin
                        state <= 2'b01; // Move back to state B
                    end

                    if (w == 1) begin
                        z <= 1; // Set output z to 1
                    end else begin
                        z <= 0; // Set output z to 0
                    end
                end
        endcase
    end
end

endmodule

