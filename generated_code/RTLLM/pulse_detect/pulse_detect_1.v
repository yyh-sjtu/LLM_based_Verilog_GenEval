
module pulse_detect (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

typedef enum logic [2:0] {
    IDLE,
    TRANSITION_1,
    TRANSITION_2,
    PULSE_DETECT
} state_type;

reg [2:0] state;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data_in == 1) begin
                    state <= TRANSITION_1;
                end
            end
            TRANSITION_1: begin
                if (data_in == 0) begin
                    state <= TRANSITION_2;
                end
            end
            TRANSITION_2: begin
                if (data_in == 1) begin
                    state <= PULSE_DETECT;
                end
            end
            PULSE_DETECT: begin
                if (data_in == 0) begin
                    state <= IDLE;
                    data_out <= 1;
                end else begin
                    data_out <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule