
module pulse_detect(
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// Declare state register
reg [2:0] state;

// State machine for pulse detection
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= 3'b000; // Initial state
        data_out <= 1'b0; // No pulse
    end
    else begin
        case(state)
            3'b000: begin // State 0
                if (data_in) begin
                    state <= 3'b001;
                end
            end
            3'b001: begin // State 1
                if (~data_in) begin
                    state <= 3'b010;
                end
            end
            3'b010: begin // State 2
                if (data_in) begin
                    state <= 3'b011;
                end
                else begin
                    state <= 3'b000;
                end
            end
            3'b011: begin // State 3 (end state)
                data_out <= 1'b1; // Pulse detected
                state <= 3'b000;
            end
            default: state <= 3'b000;
        endcase
    end
end

endmodule