
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

// Define states for pulse detection
parameter IDLE = 2'b00;
parameter PULSE_DETECTED = 2'b01;

// Declare state register
reg [1:0] state;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data_in) begin
                    state <= PULSE_DETECTED;
                end
            end
            PULSE_DETECTED: begin
                if (!data_in) begin
                    state <= IDLE;
                    data_out <= 1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule