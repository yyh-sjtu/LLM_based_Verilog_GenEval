module pulse_detect (
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg data_out
);

    // State declaration
    reg [2:0] state;

    // State machine implementation
    always @ (posedge clk or negedge rst_n)
    begin
        if (~rst_n) begin
            state <= 3'b000; // Initial state
            data_out <= 1'b0; // Output 0 indicating no pulse
        end
        else begin
            case (state)
                3'b000: // State 0
                    begin
                        if (data_in) begin
                            state <= 3'b001; // Transition to state 1
                        end
                    end
                3'b001: // State 1
                    begin
                        if (~data_in) begin
                            state <= 3'b010; // Transition to state 2
                        end
                        else begin
                            state <= 3'b000; // Reset to state 0
                        end
                    end
                3'b010: // State 2
                    begin
                        if (data_in) begin
                            state <= 3'b011; // Transition to state 3
                        end
                        else begin
                            state <= 3'b000; // Reset to state 0
                        end
                    end
                3'b011: // State 3
                    begin
                        state <= 3'b000; // Reset to state 0
                        data_out <= 1'b1; // Output 1 indicating end of pulse
                    end
                default: 
                    state <= 3'b000; // Reset to state 0
            endcase
        end
    end

endmodule

